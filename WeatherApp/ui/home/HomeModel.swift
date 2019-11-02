//
//  HomeModel.swift
//  WeatherApp
//
//  Created by Omar Chaabouni on 01/11/2019.
//  Copyright © 2019 Omar Chaabouni. All rights reserved.
//

import Foundation

struct HomeModel {
    let temperature: Int?
    let humidity: Int?
    let avgWind: Int?
    let windDirection: WindDirection?
    let rain: RainLevel?
    let errorMessage: String?
    
    init(temperature: Int? = nil,
         humidity: Int? = nil,
         avgWind: Int? = nil,
         windDirection: WindDirection? = nil,
         rain: RainLevel? = nil,
         errorMessage: String? = nil) {
        self.temperature = temperature
        self.humidity = humidity
        self.avgWind = avgWind
        self.windDirection = windDirection
        self.rain = rain
        self.errorMessage = errorMessage
    }
}
