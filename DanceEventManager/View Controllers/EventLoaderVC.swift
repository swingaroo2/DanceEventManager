//
//  EventLoaderVC.swift
//  DanceEventManager
//
//  Created by Zach Lockett-Streiff on 9/1/18.
//  Copyright © 2018 Swingaroo2. All rights reserved.
//

import UIKit

class EventLoaderVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var eventPickerTextField: UITextField!
    @IBOutlet weak var newEventFieldsContainerView: UIView!
    @IBOutlet weak var newEventNameTextField: UITextField!
    @IBOutlet weak var startDatePicker: UITextField!
    @IBOutlet weak var endDatePicker: UITextField!
    
    var events:Array<Event>! = []
    var selectedEventRow:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !Constants().IsUserLoggedIn && !Constants().BypassLogin {
            AuthService.showLogin(self.navigationController!) { self.setUpView() }
        } else {
            self.setUpView()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpView() {
        self.edgesForExtendedLayout = []
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.setUpDatePickers()
        self.loadEvents()
        self.populateEventPickerTextField()
    }
    
    func loadEvents() {
        let eventsService:EventsService = EventsService()
        let loadedEvents:Array<Event> = eventsService.loadEvents()
        self.events = loadedEvents
    }
    
    func populateEventPickerTextField() {
        var pickerArray:Array<String> = self.events.map { $0.getEventNameWithYear() }
        pickerArray.append("New Event")
        
        if pickerArray.count > 1 {
            self.eventPickerTextField.loadDropdownData(data: pickerArray)
            let eventPickerView:CustomPickerView = self.eventPickerTextField.inputView as! CustomPickerView
            eventPickerView.delegate = self
            eventPickerView.dataSource = self
        } else {
            self.newEventFieldsContainerView.isHidden = false
        }
        
        let eventPickerDoneButton:UIBarButtonItem = self.getEventPickerDoneButton()
        eventPickerDoneButton.target = self
        eventPickerDoneButton.action = #selector(eventPickerDoneButtonPressed)
        
    }
    
    func setUpDatePickers() {
        self.newEventFieldsContainerView.isHidden = true
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
        let toolBar:UIToolbar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton:UIBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(EventLoaderVC.datePickerDoneButtonPressed(_:)))
        let spaceButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton, spaceButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }

    @objc func datePickerValueChanged(_ sender:UIDatePicker) {
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy"
        let dateStr:String = formatter.string(from: sender.date)
        
        if self.startDatePicker.isFirstResponder {
            self.startDatePicker.text = dateStr
        } else if self.endDatePicker.isFirstResponder {
            self.endDatePicker.text = dateStr
        }
    }
    
    @objc func datePickerDoneButtonPressed(_ sender:Any) {
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy"
        if self.startDatePicker.isFirstResponder {
            let dateStr:String = formatter.string(from: (self.startDatePicker.inputView as! UIDatePicker).date)
            self.startDatePicker.text = dateStr
        } else if self.endDatePicker.isFirstResponder {
            let dateStr:String = formatter.string(from: (self.endDatePicker.inputView as! UIDatePicker).date)
            self.endDatePicker.text = dateStr
        }

        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func updateDatePickersWithEvent(_ event:Event) {
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy"
        
        let startDateStr:String = formatter.string(from: event.startDate)
        let endDateStr:String = formatter.string(from: event.endDate)
        
        self.startDatePicker.text = startDateStr
        self.endDatePicker.text = endDateStr
    }
    
    func clearDatePickers() {
        self.startDatePicker.text = ""
        self.endDatePicker.text = ""
    }
    
    private func getEventPickerDoneButton() -> UIBarButtonItem {
        let toolbar:UIToolbar = self.eventPickerTextField.inputAccessoryView as! UIToolbar
        var barButton:UIBarButtonItem = UIBarButtonItem()
        for item:UIBarButtonItem in toolbar.items! {
            if item.title == "Done" {
                barButton = item
            }
        }
        return barButton
    }
    
    @objc private func eventPickerDoneButtonPressed() {
        self.newEventFieldsContainerView.isHidden = (self.eventPickerTextField.text != "New Event")
        self.eventPickerTextField.endEditing(true)
    }
    
    // MARK: Event picker callbacks
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let eventPickerView:CustomPickerView = self.eventPickerTextField.inputView as! CustomPickerView
        return eventPickerView.pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let eventPickerView:CustomPickerView = self.eventPickerTextField.inputView as! CustomPickerView
        return eventPickerView.pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let eventPickerView:CustomPickerView = self.eventPickerTextField.inputView as! CustomPickerView
        self.selectedEventRow = row
        self.eventPickerTextField.text = eventPickerView.pickerData[row]
        
        if self.eventPickerTextField.text != "New Event" {
            self.updateDatePickersWithEvent(self.events[row])
        } else {
            self.clearDatePickers()
        }
    }
    
    // MARK: IBActions
    @IBAction func signOutButtonPressed(_ sender: UIBarButtonItem) {
        AuthService.signOut(self.navigationController!)
    }
    
    @IBAction func showStartDatePicker(_ sender: UITextField) {}
    @IBAction func showEndDatePicker(_ sender: UITextField) {}
    
}
