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
    
    func getProvisions(_ latitude: Double, longitude: Double) -> Single<Data> {
        return APIProvider.shared.path(Constant.apiURL.rawValue)
            .params(["_ll": "\(longitude),\(latitude)",
                     "_auth": Constant.apiAuth.rawValue,
                     "_c": Constant.apiKey.rawValue])
            .method(.get)
            .requestData()
            .map({ data -> Data in
                return data
            })
    }
}
