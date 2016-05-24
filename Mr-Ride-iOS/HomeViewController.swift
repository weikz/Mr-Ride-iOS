//
//  ViewController.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/5/23.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {

    @IBOutlet weak var totalDistance: UILabel!
    @IBOutlet weak var totalDistanceCount: UILabel!
    @IBOutlet weak var totalCounts: UILabel!
    @IBOutlet weak var totalCountsCount: UILabel!
    @IBOutlet weak var averageSpeed: UILabel!
    @IBOutlet weak var averageSpeedCount: UILabel!
    
    @IBOutlet weak var buttonLetsRide: UIButton!
    
    @IBOutlet weak var logoBike: UIImageView!
    @IBOutlet weak var buttonBar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonLetsRide.layer.cornerRadius = 30
        
        // change buttonBar color
        let origImage = UIImage(named: "icon-list");
        let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        buttonBar.setImage(tintedImage, forState: .Normal)
        buttonBar.tintColor = UIColor.whiteColor()
        
        // change logoBike color
        logoBike.image = logoBike.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        logoBike.tintColor = UIColor.whiteColor()
        
        //UIBarButtonItem
        //NSAttributedString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

