//
//  CreateAccountVC.swift
//  DanceEventManager
//
//  Created by Zach Lockett-Streiff on 6/16/18.
//  Copyright © 2018 Swingaroo2. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    // TODO: Create AvailabilityView
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backToLoginScreenPressed(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitButtonPressed() {
        print("Submit button pressed!")
    }
    
    @IBAction func roleSegmentedControlValueChanged(_ sender: UISegmentedControl) {
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
