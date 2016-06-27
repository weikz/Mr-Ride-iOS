//
//  SideMenuTableViewController.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/6/8.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//

import UIKit


class SideMenuTableViewController: UITableViewController {

    let barItems = ["Home", "History", "Map"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return barItems.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SideMenuCell", forIndexPath: indexPath) as! SideMenuTableViewCell
        cell.cellButton.text = barItems[indexPath.row]
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch barItems[indexPath.row] {
            case "Home": performSegueWithIdentifier("Show Home", sender: self)
            case "History": performSegueWithIdentifier("Show History", sender: self)
            case "Map": performSegueWithIdentifier("Show Map", sender: self)
        default: break
        }
    }
    


    
}
