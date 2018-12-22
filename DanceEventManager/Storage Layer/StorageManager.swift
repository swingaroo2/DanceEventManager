//
//  StorageManager.swift
//  DanceEventManager
//
//  Created by Zach Lockett-Streiff on 10/13/18.
//  Copyright © 2018 Swingaroo2. All rights reserved.
//

import Foundation
import AWSCore
import AWSDynamoDB

class StorageManager : NSObject {    
    let objectMapper:AWSDynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
}
