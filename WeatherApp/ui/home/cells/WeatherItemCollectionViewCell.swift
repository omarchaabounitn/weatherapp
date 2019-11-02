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
//        self.tempLabel.text = "\(temperature)°C"
//        self.hourLabel.text = hour + "h"
//        self.humidityLabel.text = "\(humidity.prefix(4))%"
//        self.windSpeedLabel.text = windDirection
//        self.windLabel.text = "\(windValue)km/h"
//        switch status {
//        case .cloudy:
//            weatherImageView.image = #imageLiteral(resourceName: "cloud")
//        case .sunny:
//            weatherImageView.image = #imageLiteral(resourceName: "contrast")
//        case .rainy:
//            weatherImageView.image = #imageLiteral(resourceName: "rain")
//        }
    }
}
