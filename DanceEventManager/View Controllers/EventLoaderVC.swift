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
    @IBOutlet weak var startDatePicker: UITextField!
    @IBOutlet weak var endDatePicker: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpDatePickers()
        self.loadEvents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadEvents() {
        // Call out to EventLoader service
        var events:Array<String> = ["Hot Rhythm Holiday 2020"] // Placeholder for service call
        events.append("New Event") // Default entry
        self.eventPickerTextField.loadDropdownData(data: events)
    }
    
    func setUpDatePickers() {
        self.configureDatePicker(self.startDatePicker)
        self.configureDatePicker(self.endDatePicker)
    }
    
    func configureDatePicker(_ textField:UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = .date
        datePickerView.minimumDate = Date()
        datePickerView.addTarget(self, action: #selector(EventLoaderVC.datePickerValueChanged(_:)), for: .valueChanged)
        textField.inputView = datePickerView
        self.addToolbar(textField)
    }
    
    func addToolbar(_ textField:UITextField) {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(EventLoaderVC.datePickerDoneButtonPressed(_:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton, spaceButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }

    @objc func datePickerValueChanged(_ sender:UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy"
        let dateStr = formatter.string(from: sender.date)
        
        if self.startDatePicker.isFirstResponder {
            self.startDatePicker.text = dateStr
        } else if self.endDatePicker.isFirstResponder {
            self.endDatePicker.text = dateStr
        }
        
    }
    
    @objc func datePickerDoneButtonPressed(_ sender:Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy"
        if self.startDatePicker.isFirstResponder {
            let dateStr = formatter.string(from: (self.startDatePicker.inputView as! UIDatePicker).date)
            self.startDatePicker.text = dateStr
        } else if self.endDatePicker.isFirstResponder {
            let dateStr = formatter.string(from: (self.endDatePicker.inputView as! UIDatePicker).date)
            self.endDatePicker.text = dateStr
        }

        self.view.endEditing(true)
    }
    
    @IBAction func showStartDatePicker(_ sender: UITextField) {}
    @IBAction func showEndDatePicker(_ sender: UITextField) {}
}
