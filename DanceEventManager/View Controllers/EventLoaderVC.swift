//
//  EventLoaderVC.swift
//  DanceEventManager
//
//  Created by Zach Lockett-Streiff on 9/1/18.
//  Copyright © 2018 Swingaroo2. All rights reserved.
//

import UIKit

class EventLoaderVC: UIViewController {

    @IBOutlet weak var eventPickerTextField: UITextField!
    
    // TODO: Refactor this into a separate service class that fetches a user's events from the server
    let events = ["Hot Rhythm Holiday 2020"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventPickerTextField.loadDropdownData(data: events)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
