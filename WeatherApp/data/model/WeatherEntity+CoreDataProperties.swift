//
//  WeatherEntity+CoreDataProperties.swift
//  
//
//  Created by Omar Chaabouni on 03/11/2019.
//
//

import Foundation
import CoreData


extension WeatherEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherEntity> {
        return NSFetchRequest<WeatherEntity>(entityName: "WeatherEntity")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var temperature: Int32
    @NSManaged public var pressure: Int32
    @NSManaged public var humidity: Int32
    @NSManaged public var rain: Double
    @NSManaged public var wind: Int32
    @NSManaged public var windDirection: Int32

}
