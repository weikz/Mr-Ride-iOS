//
//  ViewController.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/5/23.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//

import UIKit
import SideMenu
import Amplitude_iOS

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
        Amplitude.instance().logEvent("select_ride_in_home")
    }
    
    @IBAction func sideMenuButton(sender: UIBarButtonItem) {
        Amplitude.instance().logEvent("select_menu_in_home")
    }
    
    @IBOutlet weak var sideMenuButton: UIBarButtonItem!
    
    }

// MARK: - View Life Cycle
extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLogo()
        setupSideMenu()
        setupLetsRideButton()
        
        Amplitude.instance().logEvent("view_in_home")
    }
    
    
    func thumbsUpButtonPressed() {
        print("thumbs up button pressed")
    }
}

// MARK: - Setup
extension HomeViewController {
    func setupLogo() {
        let logo = UIImageView(image: UIImage(named: "logo-bike.png"))
        logo.image = logo.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        logo.tintColor = .whiteColor()
        self.navigationItem.titleView = logo
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setupSideMenu() {
        if self.revealViewController() != nil {
            sideMenuButton.target = self.revealViewController()
            sideMenuButton.action = "revealToggle:"
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func setupLetsRideButton() {
        letsRideButton.layer.cornerRadius = 30
    }
}
