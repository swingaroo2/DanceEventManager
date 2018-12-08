//
//  OrganizationLoaderVC.swift
//  DanceEventManager
//
//  Created by Zach Lockett-Streiff on 11/4/18.
//  Copyright © 2018 Swingaroo2. All rights reserved.
//

import UIKit

class OrganizationLoaderVC : UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var organizationNameTextField: UITextField!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var newOrganizationNameContainerView: UIView!
    @IBOutlet weak var createNewOrganizationButton: UIButton!
    
    var organizationArray:Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.setEmptyTableMessage("No Organizations")
        self.getOrganizationsForLoggedInUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getOrganizationsForLoggedInUser() {
        print("Fetch organizations for logged user")
        self.organizationArray = ["Hot Rhythm Foundation", "ALX Committee"]
    }

    // MARK: Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.organizationArray.count > 0 {
            self.tableView.backgroundView = nil
        }
        
        return self.organizationArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell()
        cell.textLabel?.text = self.organizationArray[indexPath.row]
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.newOrganizationNameContainerView.isHidden.toggle()
    }
    
    @IBAction func createNewOrganizationButtonPressed() {
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
