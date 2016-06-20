//
//  RunDataTableViewCell.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/6/17.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//

import UIKit

class RunDataTableViewCell: UITableViewCell {

    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var time: UILabel!
    
    var runDataStruct = RunDataModel.runDataStruct()


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


// MARK: - Setup

extension RunDataTableViewCell {
    
    func setup() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd"
        
        data.text = "\(dateFormatter.stringFromDate(runDataStruct.date!))"
        distance.text = "\(round(runDataStruct.distance!)) km"
        //time.text = "\(runDataStruct.time)"
    }
}

