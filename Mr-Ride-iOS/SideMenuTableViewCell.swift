//
//  SideMenuTableViewCell.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/6/8.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//

import UIKit

protocol SideMenuDelegate {
    
}

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var sideMenuItem: UIButton!
    var delegate: SideMenuDelegate?
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    

}
