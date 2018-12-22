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
    @IBOutlet weak var loadEventToolbarButton: UIBarButtonItem!
    @IBOutlet weak var teamCodeTextField: UITextField!
    @IBOutlet weak var teamCodeContainerViewHeightConstraint: NSLayoutConstraint!
    
    
    var events:Array<Events>! = []
    var selectedEvent:Events!
    var selectedEventRow:Int = 0
    var selectedTeam:Teams!
    
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
//        self.navigationItem.title = self.selectedTeam._teamName
//        self.setUpDatePickers()
        self.loadEvents()
//        self.populateEventPickerTextField()
    }
    
    func loadEvents() {
        let eventsService:EventsService = EventsService()
        let loadedEvents:Array<Events> = eventsService.loadEvents()
        self.events = loadedEvents
    }
    
    func populateEventPickerTextField() {
        var pickerArray:Array<String> = self.events.map { $0.getEventNameWithYear() }
        pickerArray.append("New Event")
        
        self.eventPickerTextField.loadDropdownData(data: pickerArray)
        let eventPickerView:CustomPickerView = self.eventPickerTextField.inputView as! CustomPickerView
        eventPickerView.delegate = self
        eventPickerView.dataSource = self
        
        if self.events.count == 0 {
            self.showNewEventContainerView()
        }
        
        let eventPickerDoneButton:UIBarButtonItem = self.getEventPickerDoneButton()
        eventPickerDoneButton.target = self
        eventPickerDoneButton.action = #selector(eventPickerDoneButtonPressed)
    }
    
    func setUpDatePickers() {
        self.hideNewEventContainerView()
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
    
    func updateDatePickersWithEvent(_ event:Events) {
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy"
        
        let startDateStr:String = event._startDate!
        let endDateStr:String = event._endDate!
        
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
        if self.eventPickerTextField.text != "New Event" {
            self.hideNewEventContainerView()
        } else {
            self.showNewEventContainerView()
        }
        self.eventPickerTextField.endEditing(true)
    }
    
    private func hideNewEventContainerView() {
        self.newEventFieldsContainerView.isHidden = true
        self.loadEventToolbarButton.title = "Load Event"
    }
    private func showNewEventContainerView() {
        self.newEventFieldsContainerView.isHidden = false
        self.loadEventToolbarButton.title = "Create Event"
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
    
    // TODO: Ensure date format is consistent!
    private func createNewEventObject() -> Events {
        let newEvent:Events = Events()
        newEvent._title = self.newEventNameTextField.text!
        newEvent._startDate = self.startDatePicker.text!
        newEvent._endDate = self.endDatePicker.text!
        return newEvent
    }
    
    private func validateFields() -> Bool {
        let isAnyFieldEmpty:Bool = (self.newEventNameTextField.text?.isEmpty)! || (self.startDatePicker.text?.isEmpty)! ||
            (self.endDatePicker.text?.isEmpty)!
        return !isAnyFieldEmpty
    }
    
    func clearEventDetailsFields() {
        self.newEventNameTextField.text = ""
        self.startDatePicker.text = ""
        self.endDatePicker.text = ""
    }
    
    // MARK: Alert messages
    func showEmptyFieldsAlert() {
        let alertController:UIAlertController = UIAlertController.init(title: nil, message: "Please fill out all fields", preferredStyle: .alert)
        let okAction:UIAlertAction = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Storage layer interactions
    func executeCreateEventFlow() {
        StorageManager().objectMapper.save(self.createNewEventObject(), completionHandler: {(error: Error?) -> Void in
            if let error = error {
                print("DynamoDB Save Error: \(error.localizedDescription)")
                return
            }
            print("New Event Saved!")
            self.clearEventDetailsFields()
        })
    }
    
    func startEditingEvent() {
        print("Now editing event: \(self.selectedEvent.getEventNameWithYear())")
    }
    
    // MARK: IBActions
    @IBAction func signOutButtonPressed(_ sender: UIBarButtonItem) {
        AuthService.signOut(self.navigationController!)
    }
    
    @IBAction func loadEventButtonPressed(_ sender: UIBarButtonItem) {
        if sender.title == "Load Event" {
            self.startEditingEvent()
        } else if sender.title == "Create Event" {
            if self.validateFields() {
                self.executeCreateEventFlow()
            } else {
                self.showEmptyFieldsAlert()
            }
        }
    }
    
    @IBAction func showStartDatePicker(_ sender: UITextField) {}
    @IBAction func showEndDatePicker(_ sender: UITextField) {}
    
}
