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

class CreateEditEventVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: Dummy variables
    let applets:Array<String> = ["Volunteer Manager", "Schedule Manager"]
    
    // MARK: Local constants
    let UseConfig:Bool = true
    let AppletViewIdentifier = "AppletView"
    
    // MARK: Properties
    @IBOutlet weak var appletCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        
        if !Constants().IsUserLoggedIn && !Constants().BypassLogin {
            self.initializeLogin()
        } else {
            let eventLoaderVC:EventLoaderVC = EventLoaderVC()
            self.navigationController?.pushViewController(eventLoaderVC, animated: true)
        }
        
        self.appletCollectionView.register(UINib.init(nibName: AppletViewIdentifier, bundle: nil), forCellWithReuseIdentifier: AppletViewIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionView callbacks
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.applets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let applet:AppletView = collectionView.dequeueReusableCell(withReuseIdentifier: AppletViewIdentifier, for: indexPath) as! AppletView
        let appletName = applets[indexPath.row]
        applet.appletNameLabel.text = appletName
        return applet
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
        let config:AWSAuthUIConfiguration? = UseConfig ? self.setAuthUIViewConfig() : nil
        
        if !Constants().IsUserLoggedIn {
            AWSAuthUIViewController
                .presentViewController(with: self.navigationController!,
                                       configuration: config,
                                       completionHandler: { (provider: AWSSignInProvider, error: Error?) in
                                        if error != nil {
                                            print("Error occurred: \(String(describing: error))")
                                        } else {
                                            print("Sign-in successful!")
                                            let eventLoaderVC:EventLoaderVC = EventLoaderVC()
                                            self.navigationController?.pushViewController(eventLoaderVC, animated: true)
                                        }
                })
        }
    }
    
    func setAuthUIViewConfig() -> AWSAuthUIConfiguration? {
        let config = AWSAuthUIConfiguration()
        config.enableUserPoolsUI = true
        config.font = UIFont (name: "Helvetica Neue", size: 15)
        // Add sign-in UI config here
        return config
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
