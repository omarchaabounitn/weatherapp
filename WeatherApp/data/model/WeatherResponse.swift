//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Omar Chaabouni on 01/11/2019.
//  Copyright © 2019 Omar Chaabouni. All rights reserved.
//

import Foundation

class WeatherResponse: Decodable {
    var status: Int?
    var message: String?
    var weatherList = [Weather]()
    
    struct CodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try container.allKeys.forEach {
            switch $0.stringValue {
            case "request_state":
                self.status = try container.decode(Int.self, forKey: $0)
            case "message":
                self.message = try container.decode(String.self, forKey: $0)
            default:
                if let weatherItem = try? container.decode(Weather.self, forKey: $0) {
                    self.weatherList.append(weatherItem)
                }
            }
        }
    }
}
