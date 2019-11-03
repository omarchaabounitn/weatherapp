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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIView!
    @IBOutlet weak var todayImageView: UIImageView!
    
    // - MARK: Properties
    var dataSource = [HomeModel]()
    var disposeBag: DisposeBag? = DisposeBag()
    
    lazy var viewModel: HomeViewModel = {
        HomeViewModel(dataManager: DataManager())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.observeViewModel()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.onDidAppear()
    }
    
    private func setupUI() {
        self.collectionView.register(UINib(nibName: "WeatherItemCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "WeatherItemCollectionViewCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func observeViewModel() {
        self.viewModel.resultSubject.subscribe(onNext: {
            [weak self] result in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
            switch result {
            case .loading:
                self?.activityIndicator.startAnimating()
                
            case .error(let model):
                DispatchQueue.main.async {
                    self?.showError(model.errorMessage)
                }
                
            case .previsions(let currentPrevisionModel, let nextPrevisionsList):
                DispatchQueue.main.async {
                    self?.configureView(currentPrevision: currentPrevisionModel, laterPrevisions: nextPrevisionsList)
                }
                
            default:
                break
            }
            }, onError: { _ in
                
        }).disposed(by: self.disposeBag!)
    }
    
    deinit {
        disposeBag = nil
    }
    
    private func configureView(currentPrevision: HomeModel, laterPrevisions: [HomeModel]) {
        self.scrollView.isHidden = false
        self.dataSource = laterPrevisions
        if let rainLevel = currentPrevision.rain {
            switch rainLevel {
            case .clear:
                self.todayImageView.image = #imageLiteral(resourceName: "clearSky")
            case .littleRainy:
                self.todayImageView.image = #imageLiteral(resourceName: "cloudySky")
            case .rainy:
                self.todayImageView.image = #imageLiteral(resourceName: "rainySky")
            }
        }
        if let windDirection = currentPrevision.windDirection {
            switch windDirection {
            case .east:
                self.windDirectionLabl.text = NSLocalizedString("East", comment: "")
            case .north:
                self.windDirectionLabl.text = NSLocalizedString("North", comment: "")
            case .south:
                self.windDirectionLabl.text = NSLocalizedString("South", comment: "")
            case .west:
                self.windDirectionLabl.text = NSLocalizedString("West", comment: "")
            }
        }
        if let tempurature = currentPrevision.temperature {
            self.currentTempLabel.text = "\(tempurature)°C"
        }
        if let windAvg = currentPrevision.avgWind {
            windLabel.text = "\(windAvg) km/h"
        }
        if let humidity = currentPrevision.humidity {
            humidityLabel.text = "\(humidity) %"
        }
        collectionView.reloadData()
    }
    
    private func showError(_ message: String?) {
        self.scrollView.isHidden = true
        let alertView = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }

}

// MARK: CollectionView Delegate & DataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherItemCollectionViewCell", for: indexPath) as? WeatherItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(dataSource[indexPath.item])
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: collectionView.bounds.height)
    }
}
