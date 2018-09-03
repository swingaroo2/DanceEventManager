//
//  CustomPickerView.swift
//  DanceEventManager
//
//  Created by Zach Lockett-Streiff on 9/1/18.
//  Copyright © 2018 Swingaroo2. All rights reserved.
//

import UIKit

class CustomPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // For Reference: https://www.credera.com/blog/custom-application-development/creating-a-dropdown-field-in-swift-for-ios/
    
    var pickerData:[String]!
    var pickerTextField:UITextField!
    
    // MARK: Initializers
    init(pickerData: [String], dropdownField: UITextField) {
        super.init(frame: .zero)
        
        self.pickerData = pickerData
        self.pickerTextField = dropdownField
        
        self.delegate = self
        self.dataSource = self
        
        self.populateAndEnablePicker()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    func populateAndEnablePicker() {
        DispatchQueue.main.async {
            if self.pickerData.count > 0 {
                self.pickerTextField.text = self.pickerData[0]
                self.pickerTextField.isEnabled = true
            } else {
                self.pickerTextField.text = nil
                self.pickerTextField.isEnabled = false
            }
        }
    }
    
    // MARK: UIPickerView data source and delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

}
