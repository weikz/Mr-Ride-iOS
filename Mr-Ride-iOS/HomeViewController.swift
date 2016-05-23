//
//  ViewController.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/5/23.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var logoBike: UIImageView!
    
    @IBOutlet weak var barHamburger: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set side bar action
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        barHamburger.userInteractionEnabled = true
        barHamburger.addGestureRecognizer(tapGestureRecognizer)
        
        //

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imageTapped(img: AnyObject) {
        
    }


}

