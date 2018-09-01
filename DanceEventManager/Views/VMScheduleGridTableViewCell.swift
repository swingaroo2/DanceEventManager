//
//  VMScheduleGridTableViewCell.swift
//  DanceEventManager
//
//  Created by Zach Lockett-Streiff on 7/2/18.
//  Copyright © 2018 Swingaroo2. All rights reserved.
//

import UIKit

extension VMScheduleGridTableViewCell {
    enum ScheduleGridCellStateEnum {
        case HeaderRow
        case NonHeaderRow
    }
}

class VMScheduleGridTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var volunteerNameLabel: UILabel!
    @IBOutlet weak var timelineCollectionView: UICollectionView!
    
    let testDataSourceTimeBlocks:Array<String> = ["12am", "1am", "2am", "3am", "4am", "5am", "6am", "7am", "8am", "9am", "10am", "11am",
                                                  "12pm", "1pm", "2pm", "3pm", "4pm", "5pm", "6pm", "7pm", "8pm", "9pm", "10pm", "11pm"]
    var rowState:ScheduleGridCellStateEnum!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.timelineCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.rowState == ScheduleGridCellStateEnum.HeaderRow {
            return self.testDataSourceTimeBlocks.count
        }
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .yellow
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let headerRowWidth:CGFloat = collectionView.frame.size.width / CGFloat(self.testDataSourceTimeBlocks.count)
        let width:CGFloat = (self.rowState == ScheduleGridCellStateEnum.HeaderRow) ? headerRowWidth : collectionView.frame.size.width
        let size:CGSize = CGSize.init(width: width, height: collectionView.frame.height)
        return size
    }
}
