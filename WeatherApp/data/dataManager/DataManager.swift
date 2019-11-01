//
//  DataManager.swift
//  WeatherApp
//
//  Created by Omar Chaabouni on 28/10/2019.
//  Copyright © 2019 Omar Chaabouni. All rights reserved.
//

import Foundation
import RxSwift


class DataManager {
    
    static let shared = DataManager()
    
    func getProvisions(_ latitude: Double, _ longitude: Double) -> Single<[Weather]> {
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
                return response.weatherList
            })
    }
}
