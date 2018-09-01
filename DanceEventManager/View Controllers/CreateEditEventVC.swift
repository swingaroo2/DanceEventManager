//
//  CreateEditEventVC.swift
//  DanceEventManager
//
//  Created by Zach Lockett-Streiff on 9/1/18.
//  Copyright © 2018 Swingaroo2. All rights reserved.
//

import UIKit
import AWSCore
import AWSAuthUI

class CreateEditEventVC: UIViewController {
    let isUserLoggedIn:Bool = AWSSignInManager.sharedInstance().isLoggedIn
    let useConfig:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !isUserLoggedIn {
            self.initializeLogin()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: IBActions
    @IBAction func signOutButtonPressed(_ sender: UIBarButtonItem) {
        AWSSignInManager.sharedInstance().logout(completionHandler: {(result:Any?, error:Error?) in
            print("Sign-out successful")
            self.initializeLogin()
        })
    }
    
    // MARK: Login Setup (should be in a separate class)
    func initializeLogin() {
        let config:AWSAuthUIConfiguration? = useConfig ? self.setAuthUIViewConfig() : nil
        
        
        if !AWSSignInManager.sharedInstance().isLoggedIn {
            AWSAuthUIViewController
                .presentViewController(with: self.navigationController!,
                                       configuration: config,
                                       completionHandler: { (provider: AWSSignInProvider, error: Error?) in
                                        if error != nil {
                                            print("Error occurred: \(String(describing: error))")
                                        } else {
                                            print("Sign-in successful!")
                                        }
                })
        }
    }
    
    func setAuthUIViewConfig() -> AWSAuthUIConfiguration? {
        let config = AWSAuthUIConfiguration()
        config.enableUserPoolsUI = true
        config.font = UIFont (name: "Helvetica Neue", size: 15)
        // Add sign-in UI config here
        return useConfig ? config : nil
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
