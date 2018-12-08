//
//  AuthService.swift
//  DanceEventManager
//
//  Created by Zach Lockett-Streiff on 10/11/18.
//  Copyright © 2018 Swingaroo2. All rights reserved.
//

import Foundation
import AWSCore
import AWSAuthUI

class AuthService : NSObject {
    
    // Local Constants
    static let UseConfig:Bool = true
    static var loginCompletion:() -> Void = {}
    
    static func showLogin(_ navigationController:UINavigationController, completion:@escaping () -> Void) {
        let config:AWSAuthUIConfiguration? = UseConfig ? AuthService.setAuthUIViewConfig() : nil

        // To present empty UINavigationController as modal without animation.
        AWSAuthUIViewController.presentViewController(with: navigationController,
                                   configuration: config,
                                   completionHandler: { (provider: AWSSignInProvider, error: Error?) in
                                    if error != nil {
                                        print("Error occurred: \(String(describing: error))")
                                    } else {
                                        print("Sign-in successful!")
                                        completion()
                                        AuthService.loginCompletion = completion
                                    }
        })

    }
    
    static func signOut(_ navigationController:UINavigationController) {
        AWSSignInManager.sharedInstance().logout(completionHandler: {(result: Any?, error: Error?) in
            self.showLogin(navigationController, completion:AuthService.loginCompletion)
        })
    }
    
    private static func setAuthUIViewConfig() -> AWSAuthUIConfiguration? {
        let config = AWSAuthUIConfiguration()
        config.enableUserPoolsUI = true
        config.font = UIFont (name: "Helvetica Neue", size: 15)
        // Add sign-in UI config here
        return config
    }
}
