//
//  DetailsModel.swift
//  WeatherApp
//
//  Created by Omar Chaabouni on 03/11/2019.
//  Copyright © 2019 Omar Chaabouni. All rights reserved.
//

import Foundation

struct DetailsModel {
    let temperature: Int?
    let humidity: Int?
    let avgWind: Int?
    let windDirection: WindDirection?
    let rain: RainLevel?
    let pressure: Int?
    
    init(temperature: Int? = nil,
         humidity: Int? = nil,
         avgWind: Int? = nil,
         windDirection: WindDirection? = nil,
         rain: RainLevel? = nil,
         pressure: Int? = nil) {
        self.temperature = temperature
        self.humidity = humidity
        self.avgWind = avgWind
        self.windDirection = windDirection
        self.rain = rain
        self.pressure = pressure
    }
}
