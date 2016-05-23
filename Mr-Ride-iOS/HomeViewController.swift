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

    @IBOutlet weak var logoBike: UIImageView!
    @IBOutlet weak var buttonBar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        // Dispose of any resources that can be recreated.
    }
    


}

