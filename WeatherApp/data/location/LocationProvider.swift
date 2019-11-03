////
////  LocationProvider.swift
////  WeatherApp
////
////  Created by Omar Chaabouni on 02/11/2019.
////  Copyright © 2019 Omar Chaabouni. All rights reserved.
////
//
//import Foundation
//import CoreLocation
//import RxCoreLocation
//import RxSwift
//
//enum LocationError: Error {
//    case couldNotDetermineLocation
//}
//class LocationProvider {
//
//    let manager = CLLocationManager()
//
//    func requestLocation() -> Observable<CLLocationCoordinate2D> {
//        return Observable<CLLocationCoordinate2D>.create({ single in
//            self.manager.requestWhenInUseAuthorization()
//            _ = self.manager.rx.didChangeAuthorization.subscribe(onNext: {
//                switch $1 {
//                case .authorizedWhenInUse:
//                    _ = self.manager.rx.location.subscribe(onNext: { location in
//                        if let location = location {
//                            single.onNext(location.coordinate)
//                        } else {
//                            single.onError(LocationError.couldNotDetermineLocation)
//                        }
//                    },  onError: {  _ in })
//                default:
//                    single.onError(LocationError.couldNotDetermineLocation)
//                }
//            }, onError: {
//                _ in
//            })
//        })
//    }
//
//}
