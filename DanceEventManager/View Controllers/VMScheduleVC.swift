//
//  VMScheduleVC.swift
//  DanceEventManager
//
//  Created by Zach Lockett-Streiff on 6/22/18.
//  Copyright © 2018 Swingaroo2. All rights reserved.
//

import UIKit

class VMScheduleVC: UIViewController {

    var isMenuOpen:Bool = false
    
    @IBOutlet weak var previousDayButton: UIButton!
    @IBOutlet weak var nextDayButton: UIButton!
    @IBOutlet weak var volunteersTasksControl: UISegmentedControl!
    @IBOutlet weak var dayFullEventControl: UISegmentedControl!
    @IBOutlet weak var displayedDateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func toggleMenu(_ sender: UIBarButtonItem) {
        sender.title = isMenuOpen ? "Close Menu" : "Open Menu"
        // Do shit
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
