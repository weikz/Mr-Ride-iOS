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

    @IBOutlet weak var totalDistanceCount: UILabel!
    @IBOutlet weak var totalCountsCount: UILabel!
    @IBOutlet weak var averageSpeedCount: UILabel!
    @IBOutlet weak var letsRideButton: UIButton!
    
    @IBAction func letsRideButton(sender: UIButton) {
        let newRecordViewController = self.storyboard?.instantiateViewControllerWithIdentifier("NewRecordViewController") as! NewRecordViewController
        let navigationControllerForRootView = UINavigationController(rootViewController: newRecordViewController)
        self.presentViewController(navigationControllerForRootView, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.MRLightblueColor()
        
        // Set Navigation Bar Item Logo
        let logo = UIImageView(image: UIImage(named: "logo-bike.png"))
        logo.image = logo.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        logo.tintColor = .whiteColor()
        self.navigationItem.titleView = logo
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // Set Let's Ride button
        letsRideButton.layer.cornerRadius = 30
        
        //NSAttributedString Use To Count's string interpolation
        
        let button = UIButton(type: .Custom)
        button.frame = CGRectMake(160, 100, 50, 50)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.setImage(UIImage(named:"thumbsUp.png"), forState: .Normal)
        button.addTarget(self, action: #selector(thumbsUpButtonPressed), forControlEvents: .TouchUpInside)
        view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func thumbsUpButtonPressed() {
        print("thumbs up button pressed")
    }
    
}
