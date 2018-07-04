//
//  VMScheduleGridTableViewCell.swift
//  DanceEventManager
//
//  Created by Zach Lockett-Streiff on 7/2/18.
//  Copyright © 2018 Swingaroo2. All rights reserved.
//

import UIKit

class VMScheduleGridTableViewCell: UITableViewCell {

    @IBOutlet weak var volunteerNameLabel: UILabel!
    @IBOutlet weak var timelineCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
