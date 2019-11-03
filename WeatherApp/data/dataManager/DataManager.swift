//
//  DataManager.swift
//  WeatherApp
//
//  Created by Omar Chaabouni on 28/10/2019.
//  Copyright © 2019 Omar Chaabouni. All rights reserved.
//

import Foundation
import RxSwift

protocol DataManagerProtocol {
    func getProvisions(_ latitude: Double, _ longitude: Double) -> Single<[Weather]>
}

class DataManager: DataManagerProtocol {
    
    static let shared = DataManager()
    let persistanceProvier = PersistanceProvider()
    
    func getProvisions(_ latitude: Double, _ longitude: Double) -> Single<[Weather]> {
        if Network.reachability.status == .unreachable {
            return getPersistedProvisions()
        }
        return APIProvider.shared.path(Constant.apiURL.rawValue)
            .params(["_ll": "\(longitude),\(latitude)",
                     "_auth": Constant.apiAuth.rawValue,
                     "_c": Constant.apiKey.rawValue])
            .method(.get)
            .requestData()
            .map({ data -> [Weather] in
                let response = try JSONDecoder().decode(WeatherResponse.self, from: data)
                guard response.status == 200 else {
                    throw APIError.serverError(response.message)
                }
                if response.weatherList.isEmpty {
                    throw APIError.dataNotFormmated
                }
                self.persistanceProvier.savePrevisions(previsions: response.weatherList)
                return response.weatherList
            })
    }
    
    func getPersistedProvisions() -> Single<[Weather]> {
        return persistanceProvier.getPrevisions(fromDate: Date()).map({ (result) -> [Weather] in
            result.compactMap {
                Weather(temperature: Double($0.temperature),
                        pression: Int($0.pressure), pluie: $0.rain, humidite: Double($0.humidity), avgWind: Double($0.wind), windDirection: Int($0.windDirection), date: $0.date ?? Date())
            }
        })
    }
}
