//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Omar Chaabouni on 01/11/2019.
//  Copyright © 2019 Omar Chaabouni. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {

    // - MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windDirectionLabl: UILabel!
    
    // - MARK: Properties
    var dataSource = [HomeModel]()
    var disposeBag: DisposeBag? = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        disposeBag = nil
    }

}
