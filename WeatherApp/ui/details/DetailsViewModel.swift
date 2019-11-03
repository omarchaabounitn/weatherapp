//
//  DetailsViewModel.swift
//  WeatherApp
//
//  Created by Omar Chaabouni on 03/11/2019.
//  Copyright © 2019 Omar Chaabouni. All rights reserved.
//

import Foundation
import RxSwift

class DetailsViewModel {
    
    // Properties
    var selectedModel: Weather!
    var navigator: NavigatorProtocol
    var resultSubject: PublishSubject<DetailsModel> = PublishSubject<DetailsModel>()
    
    init( navigator: NavigatorProtocol) {
        self.navigator = navigator
    }
    
    func viewDidAppear() {
        let model = DetailsModel(temperature: Int((selectedModel.temperature ?? 0) - 273.15), humidity: Int(selectedModel.humidite ?? 0), avgWind: Int(selectedModel.avgWind ?? 0), windDirection: selectedModel.windDirection, rain: selectedModel.pluie, pressure: selectedModel.pression)
        resultSubject.onNext(model)
    }
    
    func onCloseTap() {
        self.navigator.dismiss()
    }
}
