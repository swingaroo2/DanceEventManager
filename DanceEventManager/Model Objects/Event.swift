//
//  Event.swift
//  DanceEventManager
//
//  Created by Zach Lockett-Streiff on 10/7/18.
//  Copyright © 2018 Swingaroo2. All rights reserved.
//

import Foundation
import AWSDynamoDB

class Event: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    var eventName:String = ""
    var startDate:String = ""
    var endDate:String = ""

    class func dynamoDBTableName() -> String {
        
        return "danceeventmanagerapp-mobilehub-1321329505-Events"
    }
    
    class func hashKeyAttribute() -> String {
        
        return "eventName"
    }
    
    class func rangeKeyAttribute() -> String {
        
        return "startDate"
    }
    
    override class func jsonKeyPathsByPropertyKey() -> [AnyHashable: Any] {
        return [
            "eventName" : "eventName",
            "startDate" : "startDate",
            "endDate" : "endDate",
        ]
    }
    
    func setStartDateWithDateObject(date:Date) {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        self.startDate = dateFormatter.string(from: date)
    }
    
    func setEndDateWithDateObject(date:Date) {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        self.endDate = dateFormatter.string(from: date)
    }
    
    func getEventNameWithYear() -> String {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        let stringToDate:Date = dateFormatter.date(from: self.startDate)!
        let yearString:String = "\(Calendar.current.component(.year, from: stringToDate))"
        let eventNameWithYear:String = "\(self.eventName) \(yearString)"
        return eventNameWithYear
    }

}
