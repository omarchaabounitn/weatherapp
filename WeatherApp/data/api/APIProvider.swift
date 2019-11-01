//
//  APIProvider.swift
//  WeatherApp
//
//  Created by Omar Chaabouni on 28/10/2019.
//  Copyright © 2019 Omar Chaabouni. All rights reserved.
//

import Foundation
import Network
import RxSwift

class APIProvider: NSObject {
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    static var shared = APIProvider()
    
    private var session: URLSession {
        return URLSession.shared
    }
    
    private var request: URLRequest!
    
    func path(_ path: String) -> APIProvider {
        let url = URL(string: path)!
        self.request = URLRequest(url: url)
        return self
    }
    
    func method(_ method: HTTPMethod) -> APIProvider {
        self.request.httpMethod = method.rawValue
        return self
    }
    
    func params(_ params: [String: String]?) -> APIProvider {
        if HTTPMethod(rawValue: request.httpMethod ?? "") == .get,
            let urlString = request.url?.absoluteString,
            let query = params?.compactMap({ String(format: "%@=%@", $0, $1) }) {
            request.url = URL(string: urlString + "?" + query.joined(separator: "&"))
        } else if HTTPMethod(rawValue: request.httpMethod ?? "") == .post {
            request.httpBody = String(describing: params).data(using: .utf8)
        }
        return self
    }
    
    func requestData() -> Single<Data> {
        return Single<Data>.create { single in
            let task = self.session.dataTask(with: self.request, completionHandler: { (data, _, error) in
                if let error = error {
                    single(.error(error))
                    return
                }
                if let data = data {
                    single(.success(data))
                }
            })
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
}
