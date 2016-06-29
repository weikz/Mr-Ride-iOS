//
//  LoginViewController.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/6/3.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!

    @IBOutlet weak var loginButton: FBSDKLoginButton!
    @IBAction func loginButton(sender: AnyObject) {
        
        
        defaults.setValue(self.heightTextField.text, forKey: "userHeight")
        defaults.setValue(self.weightTextField.text, forKey: "userWeight")
        defaults.synchronize()
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            performSegueWithIdentifier("toNewRecordPage", sender: self)
            
        } else {
            let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
            fbLoginManager.logInWithReadPermissions(["email"], fromViewController: self){ (result, error) -> Void in
                if (error == nil){
                    print("LOGIN SUCCESS!")
                }
            }
        }
    }

    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
}

//MARK: - View Life Cycle

extension LoginViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        loginButton.layer.cornerRadius = 30
    }
}

//MARK: - Setup

extension LoginViewController {
    func setupBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.MRLightblueColor().CGColor, UIColor.pineGreen50Color().CGColor]
        gradientLayer.locations = [0.5, 1]
        gradientLayer.frame = view.frame
        self.view.layer.insertSublayer(gradientLayer, atIndex: 1)
    }
}
