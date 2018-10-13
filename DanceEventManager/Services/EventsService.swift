//
//  EventsService.swift
//  DanceEventManager
//
//  Created by Zach Lockett-Streiff on 10/12/18.
//  Copyright © 2018 Swingaroo2. All rights reserved.
//

import Foundation

class EventsService : NSObject {
    
    func loadEvents() -> Array<Event> {
        
        /* Create dummy events */
        let event1:Event = Event()
        event1.eventName = "Hot Rhythm Holiday"
        event1.startDate = Date()
        var components = DateComponents()
        components.setValue(2, for: .day)
        event1.endDate = Calendar.current.date(byAdding:components, to: event1.startDate)!
        
        let event2:Event! = Event()
        event2.eventName = "Ball of Fire"
        event2.startDate = Date()
        components = DateComponents()
        components.setValue(2, for: .day)
        event2.endDate = Calendar.current.date(byAdding:components, to: event2.startDate)!
        
        let eventsArr:Array<Event> = [event1, event2]
        return eventsArr
    }
}
