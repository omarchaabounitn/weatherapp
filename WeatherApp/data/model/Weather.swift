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
    var pluie: RainLevel?
    var humidite: Double?
    var avgWind: Double?
    var windDirection: WindDirection?
    var date: Date!
    
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
    
    init( temperature: Double?,
          pression: Int?,
          pluie: Double,
          humidite: Double?,
          avgWind: Double?,
          windDirection: Int,
          date: Date) {
        self.temperature = temperature
        self.pression = pression
        self.pluie = RainLevel(rawValue: pluie)
        self.humidite = humidite
        self.avgWind = avgWind
        self.windDirection = WindDirection(rawValue: windDirection)
        self.date = date
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let tempContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: CodingKeys.temperature) {
            self.temperature = try tempContainer.decode(Double.self, forKey: .twoM)
        }
        if let pressionContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: CodingKeys.pression) {
            self.pression = try pressionContainer.decode(Int.self, forKey: .pressionSeaLevel)
        }
        pluie = RainLevel(rawValue: try container.decode(Double.self, forKey: .pluie))
        if let humidityContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: CodingKeys.humidite) {
            self.humidite = try humidityContainer.decode(Double.self, forKey: .twoM)
        }
        if let windContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: CodingKeys.avgWind) {
            self.avgWind = try windContainer.decode(Double.self, forKey: .tenM)
        }
        if let windDirectionContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: CodingKeys.windDirection) {
            self.windDirection = WindDirection(rawValue: try windDirectionContainer.decode(Int.self, forKey: .tenM))
        }
    }
}

enum RainLevel: Double {
    case clear = 0.0
    case littleRainy = 0.5
    case rainy = 1.0

    init(rawValue: Double) {
        switch rawValue {
        case 0:
            self = .clear
        case _ where rawValue <= 0.5:
            self = .littleRainy
        default:
            self = .rainy
        }
    }
}

enum WindDirection: Int {
    case north = 0
    case east = 90
    case south = 180
    case west = 260
    
    init(rawValue: Int) {
        switch rawValue {
        case _ where rawValue >= 0 && rawValue < 90:
            self = .north
        case _ where rawValue >= 90 && rawValue < 180:
            self = .east
        case _ where rawValue >= 180 && rawValue < 260:
            self = .south
        default:
            self = .west
        }
    }
}
