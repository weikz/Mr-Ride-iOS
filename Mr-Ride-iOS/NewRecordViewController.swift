//
//  NewRecordViewController.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/5/24.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//

import UIKit
import GoogleMaps

class NewRecordViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addGradient() {
        let layer = CAGradientLayer()
        layer.frame = self.view.bounds
        layer.colors = [UIColor.blackColor().colorWithAlphaComponent(0.6).CGColor, UIColor.blackColor().colorWithAlphaComponent(0.4).CGColor]
        view.layer.insertSublayer(layer, atIndex: 0)
    }
}
