//
//  Navigator.swift
//  WeatherApp
//
//  Created by Omar Chaabouni on 03/11/2019.
//  Copyright © 2019 Omar Chaabouni. All rights reserved.
//

import UIKit


protocol NavigatorProtocol {
    func goToDetails(_ selectedWeather: Weather)
    func dismiss()
}

class Navigator: NavigatorProtocol {
    
    // Properties
    let viewController: UIViewController
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func goToDetails(_ selectedWeather: Weather) {
        if let detailsViewController = UIStoryboard(name: "Details", bundle: Bundle.main).instantiateInitialViewController() as? DetailsViewController {
            detailsViewController.viewModel.selectedModel = selectedWeather
            self.viewController.present(detailsViewController, animated: true, completion: nil)
        }
    }
    
    func dismiss() {
        self.viewController.dismiss(animated: true, completion: nil)
    }
}
