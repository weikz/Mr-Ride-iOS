//
//  LoginViewController.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/6/3.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import SwiftValidator

class LoginViewController: UIViewController {
    let validator = Validator()
    
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!

    @IBOutlet weak var loginButton: FBSDKLoginButton!
    @IBAction func loginButton(sender: AnyObject) {
        validator.validate(self)
    }

    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
}

//MARK: - View Life Cycle

extension LoginViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupValidate()
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
    
    func setupValidate() {
        validator.styleTransformers(success:{ (validationRule) -> Void in
            validationRule.errorLabel?.hidden = true
            validationRule.errorLabel?.text = ""
            if let textField = validationRule.textField as? UITextField {
                textField.layer.borderColor = UIColor.greenColor().CGColor
                textField.layer.borderWidth = 0.5
                
            }
            }, error:{ (validationError) -> Void in
                validationError.errorLabel?.hidden = false
                validationError.errorLabel?.text = validationError.errorMessage
                if let textField = validationError.textField as? UITextField {
                    textField.layer.borderColor = UIColor.redColor().CGColor
                    textField.layer.borderWidth = 1.0
                }
        })
        
        validator.registerField(heightTextField, rules: [RequiredRule(),FloatRule()])
        validator.registerField(weightTextField, rules: [RequiredRule(),FloatRule()])

    }
}

//MARK: - ValidatorDelegate

extension LoginViewController: ValidationDelegate {
    func validationSuccessful() {
        print("success")
        defaults.setValue(self.heightTextField.text, forKey: "userHeight")
        defaults.setValue(self.weightTextField.text, forKey: "userWeight")
        defaults.synchronize()
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            performSegueWithIdentifier("Show Home", sender: self)
            
        } else {
            let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
            fbLoginManager.logInWithReadPermissions(["email"], fromViewController: self){ (result, error) -> Void in
                if (error == nil){
                    print("LOGIN SUCCESS!")
                }
            }
        }


    }
    
    func validationFailed(errors: [UITextField : ValidationError]) {
        print(errors)
    }
}