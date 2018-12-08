//
//  EventsService.swift
//  DanceEventManager
//
//  Created by Zach Lockett-Streiff on 10/12/18.
//  Copyright © 2018 Swingaroo2. All rights reserved.
//

import Foundation

class EventsService : NSObject {
    
    func loadEvents() -> Array<Events> {
        
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        
        /* Create dummy events */
        let event1:Events = Events()
        event1._eventName = "Hot Rhythm Holiday"
        event1.setStartDateWithDateObject(date: Date())
        var components = DateComponents()
        components.setValue(2, for: .day)
        var endDate:Date = Calendar.current.date(byAdding:components, to: Date())!
        event1.setEndDateWithDateObject(date: endDate)
        
        let event2:Events = Events()
        event2._eventName = "Ball of Fire"
        event2.setStartDateWithDateObject(date: Date())
        components = DateComponents()
        components.setValue(2, for: .day)
        endDate = Calendar.current.date(byAdding:components, to: Date())!
        event2.setEndDateWithDateObject(date: endDate)
        let eventsArr:Array<Events> = [event1, event2]
        return eventsArr
    }
}
