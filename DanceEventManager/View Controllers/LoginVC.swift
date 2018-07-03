//
//  LoginVC.swift
//  DanceEventManager
//
//  Created by Zach Lockett-Streiff on 6/15/18.
//  Copyright © 2018 Swingaroo2. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    // Constants
    let organizerString:String = "Organizer"
    let volunteerString:String = "Volunteer"
    let createAccountString:String = "Create Account"
    let applyToVolunteerString:String = "Apply to Volunteer!"
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC:CreateAccountVC = segue.destination.childViewControllers.first as? CreateAccountVC {
            if self.createAccountButton.titleLabel?.text == applyToVolunteerString
            {
                destinationVC.title = applyToVolunteerString
            } else if self.createAccountButton.titleLabel?.text == organizerString {
                destinationVC.title = createAccountString
            }
        }
    }
    
    func updateCreateAccountButtonTitle(for selectedSegmentTitle: String) {
        if selectedSegmentTitle == volunteerString
        {
            self.createAccountButton.setTitle(applyToVolunteerString, for: .normal)
        } else if selectedSegmentTitle == organizerString {
            self.createAccountButton.setTitle(createAccountString, for: .normal)
        }
    }
    
    // MARK: IBActions
    @IBAction func roleSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        guard let role:String = sender.titleForSegment(at: sender.selectedSegmentIndex) else {
            print("Could not get title for selected segment")
            return
        }
        self.updateCreateAccountButtonTitle(for: role)
    }
    
}

