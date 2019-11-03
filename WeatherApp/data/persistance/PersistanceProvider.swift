//
//  PersistanceProvider.swift
//  WeatherApp
//
//  Created by Omar Chaabouni on 03/11/2019.
//  Copyright © 2019 Omar Chaabouni. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import RxSwift

class PersistanceProvider {
    
    private let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getPrevisions(fromDate date: Date) -> Single<[WeatherEntity]> {
        return Single<[WeatherEntity]>.create { single in
            let fetchPrevisions = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherEntity")
            let nowDate = Date()
            do {
                let result = try self.managedContext.fetch(fetchPrevisions)
                let res = result.compactMap({ $0 as? WeatherEntity }).filter {
                    guard let date = $0.date else {
                        return false
                    }
                    return date > nowDate
                }
                single(.success(res))
            } catch {
                single(.error(error))
            }
            
            return Disposables.create {}
        }
    }
    
    func savePrevisions(previsions: [Weather]) {
        clearSavedPrevisions()
        _ = previsions.compactMap { entity -> NSManagedObject in
            let managedEntity = NSEntityDescription.insertNewObject(forEntityName: "WeatherEntity", into: self.managedContext)
            managedEntity.setValue(entity.date, forKey: "date")
            managedEntity.setValue(Int32(entity.temperature ?? 0), forKey: "temperature")
                managedEntity.setValue(Int32(entity.pression ?? 0), forKey: "pressure")
                managedEntity.setValue(Int32(entity.humidite ?? 0), forKey: "humidity")
                managedEntity.setValue(Int32(entity.avgWind ?? 0), forKey: "wind")
                managedEntity.setValue(Int32(entity.windDirection?.rawValue ?? 0), forKey: "windDirection")
                managedEntity.setValue(entity.pluie?.rawValue, forKey: "rain")
            return managedEntity
        }
       try? managedContext.save()
    }
    
    func clearSavedPrevisions() {
        let deleteRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherEntity")
        let request = NSBatchDeleteRequest(fetchRequest: deleteRequest)
        _ = try? managedContext.execute(request)
    }
}
