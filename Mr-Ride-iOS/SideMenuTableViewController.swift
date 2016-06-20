//
//  SideMenuTableViewController.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/6/8.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuTableViewController: UITableViewController {

    let barItems = ["Home", "History", "Map"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return barItems.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch barItems[indexPath.row] {
        case "Home":
            performSegueWithIdentifier("sideMenuToHomePage", sender: nil)
            
        case "History":
            performSegueWithIdentifier("sideMenuToHistoryPage", sender: nil)
        
        case "Map":
            performSegueWithIdentifier("sideMenuToMapPage", sender: nil)
        default: break
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sideMenuCell", forIndexPath: indexPath) as! SideMenuTableViewCell
        cell.sideMenuItem.setTitle(barItems[indexPath.row], forState: .Normal)
        
        
        return cell
    }
    


    
}

extension SideMenuTableViewController: SideMenuDelegate {
    
}
