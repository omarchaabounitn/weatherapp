//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Omar Chaabouni on 01/11/2019.
//  Copyright © 2019 Omar Chaabouni. All rights reserved.
//

import Foundation
import RxSwift

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
}
