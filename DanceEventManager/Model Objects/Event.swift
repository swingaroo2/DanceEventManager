//
//  Event.swift
//  DanceEventManager
//
//  Created by Zach Lockett-Streiff on 10/7/18.
//  Copyright © 2018 Swingaroo2. All rights reserved.
//

import Foundation

class Event: NSObject {
    var eventName:String = ""
    var startDate:Date = Date()
    var endDate:Date = Date()

    func getEventNameWithYear() -> String {
        let year:String = "\(Calendar.current.component(.year, from: self.startDate))"
        let eventNameWithYear:String = "\(self.eventName) \(year)"
        return eventNameWithYear
    }

}
