//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Omar Chaabouni on 01/11/2019.
//  Copyright © 2019 Omar Chaabouni. All rights reserved.
//

import Foundation
import RxSwift
import CoreLocation
import RxCoreLocation

enum WeatherStatus: Int {
    case sunny = 1
    case cloudy = 2
    case rainy = 3
}

class HomeViewModel: NSObject {
    
    enum ResultState {
        case error(HomeModel)
        case previsions(current: HomeModel, nextPrivisions: [HomeModel])
        case loading
        case none
    }
    
    // Properties
    var resultSubject: PublishSubject<ResultState> = PublishSubject<ResultState>()
    var dataManager: DataManager
    var locationManager: CLLocationManager
    var disposeBag: DisposeBag?
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        self.locationManager = CLLocationManager()
        self.disposeBag = DisposeBag()
    }
    
    func onDidAppear() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.rx.didChangeAuthorization.subscribe(onNext: {
            switch $1 {
            case .authorizedAlways, .authorizedWhenInUse:
                self.locationManager.rx.location.subscribe({ [weak self] event in
                    if let location = event.element as? CLLocation {
                        self?.getLocation(location.coordinate.latitude, latitude: location.coordinate.longitude)
                    }
                }).disposed(by: self.disposeBag!)
            case .denied:
                self.resultSubject.onNext(.error(HomeModel(errorMessage: NSLocalizedString("Location Permission is required for this app to work. Please change the permission in settings.", comment: ""))))
            default:
                self.resultSubject.onNext(.error(HomeModel(errorMessage: NSLocalizedString("Could not determinate your location. Please try again", comment: ""))))
            }
        }, onError: { _ in }).disposed(by: disposeBag!)
    }
    
    func getLocation(_ longitude: Double, latitude: Double) {
        self.resultSubject.onNext(.loading)
        self.dataManager.getProvisions(latitude, longitude).subscribe(onSuccess: { [weak self] previsions in
            var previsionsList = previsions.sorted(by: { $0.date < $1.date }).compactMap {
                HomeModel(temperature: Int(($0.temperature ?? 0) - 273.15), humidity: Int($0.humidite ?? 0), avgWind: Int($0.avgWind ?? 0), windDirection: $0.windDirection, rain: $0.pluie, hour: DateUtils.getComponant(componant: .hour, fromDate: $0.date), errorMessage: nil)
            }
            previsionsList = Array(previsionsList.prefix(7))
            let currentPrevision = previsionsList.remove(at: 0)
            self?.resultSubject.onNext(.previsions(current: currentPrevision, nextPrivisions: previsionsList))
            
        }, onError: { [weak self] _ in
            self?.resultSubject.onNext(.error(HomeModel(errorMessage: NSLocalizedString("Could not determinate your location. Please try again", comment: ""))))
        }).disposed(by: disposeBag!)
    }
    
    deinit {
        disposeBag = nil
    }
}
