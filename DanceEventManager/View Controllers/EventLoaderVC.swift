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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadEvents()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadEvents() {
        // Call out to EventLoader service
        var events:Array<String> = ["Hot Rhythm Holiday 2020"] // Placeholder for service call
        events.append("New Event") // Default entry
        self.eventPickerTextField.loadDropdownData(data: events)
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
