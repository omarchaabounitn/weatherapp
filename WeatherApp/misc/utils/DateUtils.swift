//
//  DateUtils.swift
//  WeatherApp
//
//  Created by Omar Chaabouni on 01/11/2019.
//  Copyright © 2019 Omar Chaabouni. All rights reserved.
//

import Foundation

class DateUtils: NSObject {
    
    static func getDate(from stringDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: stringDate) ?? Date()
    }
    
    static func getComponant(componant: Calendar.Component ,fromDate date: Date) -> Int {
        return Calendar.current.component(componant, from: date)
    }
}
