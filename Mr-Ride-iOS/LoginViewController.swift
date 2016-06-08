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
        
        
        defaults.setObject(self.heightTextField.text, forKey: "userHeight")
        defaults.setObject(self.weightTextField.text, forKey: "userWeight")
        defaults.synchronize()
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            performSegueWithIdentifier("toNewRecordPage", sender: self)
            
//            let newViewController = UIViewController()
//            
//            UIApplication.sharedApplication().delegate?.window??.rootViewController = newViewController
            
        } else {
            let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
            fbLoginManager.logInWithReadPermissions(["email"], fromViewController: self){ (result, error) -> Void in
                if (error == nil){
                    print("LOGIN SUCCESS!")
                }
            }
        }
    }

    var fbButton:FBSDKLoginButton = FBSDKLoginButton()
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 30
        
        view.addSubview(fbButton)
        fbButton.center = view.center
    }
}
