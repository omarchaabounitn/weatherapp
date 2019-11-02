//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Omar Chaabouni on 26/10/2019.
//  Copyright © 2019 Omar Chaabouni. All rights reserved.
//

import UIKit
import  RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        var disposableBag: DisposeBag? = DisposeBag()
        DataManager.shared.getProvisions(2.3488, 48.85341).subscribe(onSuccess: { data in
            print(data.sorted(by: { $0.date < $1.date }).compactMap({ $0.pluie }))
            disposableBag = nil
        }) { error in
            print(error)
            }.disposed(by: disposableBag!)
        return true
    }

}

