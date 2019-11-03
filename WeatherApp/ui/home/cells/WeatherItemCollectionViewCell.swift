//
//  WeatherItemCollectionViewCell.swift
//  Test
//
//  Created by Omar Chaabouni on 02/11/2019.
//  Copyright © 2019 Omar Chaabouni. All rights reserved.
//

import UIKit

class WeatherItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    func configureCell(_ model: HomeModel) {

        if let rainLevel = model.rain {
            switch rainLevel {
            case .clear:
               weatherImageView.image = #imageLiteral(resourceName: "contrast")
            case .littleRainy:
                weatherImageView.image = #imageLiteral(resourceName: "cloud")
            case .rainy:
                weatherImageView.image = #imageLiteral(resourceName: "rain")
            }
        }
        if let windDirection = model.windDirection {
            switch windDirection {
            case .east:
                self.windSpeedLabel.text = NSLocalizedString("East", comment: "")
            case .north:
                self.windSpeedLabel.text = NSLocalizedString("North", comment: "")
            case .south:
                self.windSpeedLabel.text = NSLocalizedString("South", comment: "")
            case .west:
                self.windSpeedLabel.text = NSLocalizedString("West", comment: "")
            }
        }
        if let tempurature = model.temperature {
            self.tempLabel.text = "\(tempurature)°C"
        }
        if let windAvg = model.avgWind {
            windLabel.text = "\(windAvg) km/h"
        }
        if let humidity = model.humidity {
            humidityLabel.text = "\(humidity) %"
        }
        if let hour = model.hour {
            hourLabel.text = "\(hour)"
        }
    }
}
