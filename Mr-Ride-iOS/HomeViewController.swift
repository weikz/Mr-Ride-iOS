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
    var conuter = 0
    
    @IBOutlet weak var totalDistanceCount: UILabel!
    @IBOutlet weak var totalCountsCount: UILabel!
    @IBOutlet weak var averageSpeedCount: UILabel!
    @IBOutlet weak var letsRideButton: UIButton!
    
    @IBAction func letsRideButton(sender: UIButton) {
        let newRecordViewController = self.storyboard?.instantiateViewControllerWithIdentifier("NewRecordViewController") as! NewRecordViewController
        let navigationControllerForRootView = UINavigationController(rootViewController: newRecordViewController)
        self.presentViewController(navigationControllerForRootView, animated: true, completion: nil)
    }
    
    
    
    
}

// MARK: - View Life Cycle
extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupLogo()
        setupLetsRideButton()
        
        //NSAttributedString Use To Count's string interpolation
    }
    
    
    func thumbsUpButtonPressed() {
        print("thumbs up button pressed")
    }
}

// MARK: - Setup
extension HomeViewController {
    func setupNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor.MRLightblueColor()

    }
    
    func setupLogo() {
        let logo = UIImageView(image: UIImage(named: "logo-bike.png"))
        logo.image = logo.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        logo.tintColor = .whiteColor()
        self.navigationItem.titleView = logo
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setupLetsRideButton() {
        letsRideButton.layer.cornerRadius = 30
    }
}
