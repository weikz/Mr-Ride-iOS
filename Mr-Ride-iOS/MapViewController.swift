//
//  MapViewController.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/6/14.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    var toilets = []
    func setup(){
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let abc = DataTaipeiManager()
        abc.getToilet({ [weak self] toilets in
            guard let weakSelf = self else { return }
            weakSelf.setup()
            }, failure: {error in })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
