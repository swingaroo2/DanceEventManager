//
//  TeamLoaderVC.swift
//  DanceEventManager
//
//  Created by Zach Lockett-Streiff on 11/4/18.
//  Copyright © 2018 Swingaroo2. All rights reserved.
//

import UIKit

class TeamLoaderVC : UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var teamNameTextField: UITextField!
    @IBOutlet weak var newTeamNameContainerView: UIView!
    @IBOutlet weak var createNewTeamButton: UIButton!
    
    
    let createNewTeamButtonColor = UInt(0x0433FF)
    let hideNewTeamButtonColor = UInt(0xB3090C)
    
    var teamArray:Array<String> = []
    var selectedTeam:Teams?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.setEmptyTableMessage("No Teams")
        self.getTeamsForLoggedInUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTeamsForLoggedInUser() {
        print("Fetch teams for logged user")
        self.teamArray = ["Hot Rhythm Foundation", "ALX Committee"]
    }

    // MARK: Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.teamArray.count > 0 {
            self.tableView.backgroundView = nil
        }
        
        return self.teamArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell()
        cell.textLabel?.text = self.teamArray[indexPath.row]
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    
    @IBAction func createNewTeamButtonPressed(_ sender: UIButton) {
        if self.newTeamNameContainerView.isHidden {
            self.newTeamNameContainerView.isHidden = false
            sender.setTitle("Hide New Team Prompt", for: .normal)
            sender.backgroundColor = UIColorFromRGB(rgbValue: hideNewTeamButtonColor)
        } else {
            self.newTeamNameContainerView.isHidden = true
            sender.setTitle("Create New Team", for: .normal)
            sender.backgroundColor = UIColorFromRGB(rgbValue: createNewTeamButtonColor)
        }
    }
    
    @IBAction func submitNewEventButtonPressed(_ sender: UIButton) {
        if sender.isEnabled {
            let newTeam:Teams = self.createNewTeamToSave()
            StorageManager().objectMapper.save(newTeam)
            self.tableView.reloadData()
        } else {
            print("Submit new event failed")
        }
    }
    
    func createNewTeamToSave() -> Teams {
        let newTeam:Teams = Teams()
        newTeam._teamName = self.teamNameTextField.text
        // TODO: Populate the other Teams fields
        return newTeam
    }
    
    // TODO: Move this to a helper function class
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }
}
