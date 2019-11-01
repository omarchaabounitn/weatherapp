//
//  Weather.swift
//  WeatherApp
//
//  Created by Omar Chaabouni on 01/11/2019.
//  Copyright © 2019 Omar Chaabouni. All rights reserved.
//

import Foundation

class Weather: Decodable {
    var temperature: Double?
    var pression: Int?
    var pluie: Double?
    var humidite: Double?
    var avgWind: Double?
    var windDirection: Int?
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temperature"
        case twoM = "2m"
        case pression = "pression"
        case pressionSeaLevel = "niveau_de_la_mer"
        case pluie = "pluie"
        case humidite = "humidite"
        case avgWind = "vent_moyen"
        case tenM = "10m"
        case windDirection = "vent_direction"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let tempContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: CodingKeys.temperature) {
            self.temperature = try tempContainer.decode(Double.self, forKey: .twoM)
        }
        if let pressionContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: CodingKeys.pression) {
            self.pression = try pressionContainer.decode(Int.self, forKey: .pressionSeaLevel)
        }
        pluie = try? container.decode(Double.self, forKey: .pluie)
        if let humidityContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: CodingKeys.humidite) {
            self.humidite = try humidityContainer.decode(Double.self, forKey: .twoM)
        }
        if let windContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: CodingKeys.avgWind) {
            self.avgWind = try windContainer.decode(Double.self, forKey: .tenM)
        }
        if let windDirectionContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: CodingKeys.windDirection) {
            self.windDirection = try windDirectionContainer.decode(Int.self, forKey: .tenM)
        }
    }
}
