//
//  UITableView+Custom.swift
//  DanceEventManager
//
//  Created by Zach Lockett-Streiff on 11/24/18.
//  Copyright © 2018 Swingaroo2. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func setEmptyTableMessage(_ message: String) {
        let messageLabel:UILabel = UILabel(frame: self.frame)
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
}
