//
//  Constants.swift
//  DanceEventManager
//
//  Created by Zach Lockett-Streiff on 9/1/18.
//  Copyright © 2018 Swingaroo2. All rights reserved.
//

import UIKit
import AWSCore
import AWSAuthUI

class Constants: NSObject {
    public let BypassLogin: Bool = true
    public let IsUserLoggedIn:Bool = AWSSignInManager.sharedInstance().isLoggedIn
}
