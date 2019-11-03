//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Omar Chaabouni on 03/11/2019.
//  Copyright © 2019 Omar Chaabouni. All rights reserved.
//

import UIKit
import RxSwift

class DetailsViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var windDirectionLabel: UILabel!
    @IBOutlet var weatherImageView: UIImageView!
    
    // Properties
    lazy var viewModel: DetailsViewModel = {
        DetailsViewModel(navigator: Navigator(self))
    }()
    var disposableBag: DisposeBag? = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewDidAppear()
    }
    
    private func observeViewModel() {
        self.viewModel.resultSubject.subscribe(onNext: { [weak self] model in
            DispatchQueue.main.async {
                self?.setupUI(model: model)
            }
            }, onError: { _ in
        }).disposed(by: self.disposableBag!)
    }
    
    private func setupUI(model: DetailsModel) {
        if let rainLevel = model.rain {
            switch rainLevel {
            case .clear:
                self.weatherImageView.image = #imageLiteral(resourceName: "contrast")
            case .littleRainy:
                self.weatherImageView.image = #imageLiteral(resourceName: "cloud")
            case .rainy:
                self.weatherImageView.image = #imageLiteral(resourceName: "rain")
            }
        }
        if let windDirection = model.windDirection {
            switch windDirection {
            case .east:
                self.windDirectionLabel.text = NSLocalizedString("East", comment: "")
            case .north:
                self.windDirectionLabel.text = NSLocalizedString("North", comment: "")
            case .south:
                self.windDirectionLabel.text = NSLocalizedString("South", comment: "")
            case .west:
                self.windDirectionLabel.text = NSLocalizedString("West", comment: "")
            }
        }
        if let tempurature = model.temperature {
            self.temperatureLabel.text = "\(tempurature)°C"
        }
        if let windAvg = model.avgWind {
            windSpeedLabel.text = "\(windAvg) km/h"
        }
        if let humidity = model.humidity {
            humidityLabel.text = "\(humidity) %"
        }
        if let pressure = model.pressure {
            pressureLabel.text = "\(Int(pressure / 100)) P"
        }
    }
    
    @IBAction private func onCloseTap(_ sender: Any) {
        self.viewModel.onCloseTap()
    }
}
