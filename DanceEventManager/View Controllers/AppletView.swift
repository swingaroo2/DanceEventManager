//
//  AppletView.swift
//  DanceEventManager
//
//  Created by Zach Lockett-Streiff on 9/3/18.
//  Copyright © 2018 Swingaroo2. All rights reserved.
//

import Foundation
import UIKit

class AppletView : UICollectionViewCell {
    
    @IBOutlet weak var appletImageView: UIImageView!
    @IBOutlet weak var appletNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // TODO: Once we get images, use this function instead
    func configure(_ appletImageView:UIImageView,appletNameLabel:UILabel) {
        self.appletImageView = appletImageView
        self.appletNameLabel = appletNameLabel
    }
}
