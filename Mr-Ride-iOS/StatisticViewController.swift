//
//  StatisticViewController.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/6/2.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//

import UIKit
import CoreData


class StatisticViewController: UIViewController {

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var averageSpeedLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    let context = DataController().managedObjectContext
    let getRequest = NSFetchRequest(entityName: "Record")
    
    //data
    private let runDataModel = RunDataModel()
    var runDataStructArray: [RunDataModel.runDataStruct] = []
    var runDataStruct = RunDataModel.runDataStruct()
    
    enum PreviousPage {
        case TrackingPageViewController
        case HistoryViewController
    }
    var previousPage: PreviousPage = .TrackingPageViewController

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        addGradient()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

extension StatisticViewController {
    func getData() {
        do {
            let data = try context.executeFetchRequest(getRequest)
            distanceLabel.text = "\(round(data.last!.valueForKey("distance")! as! Double)) m"
            // averageSpeedLabel.text = "\(round(data.last!.valueForKey("averageSpeed")! as! Double)) km / h"
            caloriesLabel.text = "\(round(data.last!.valueForKey("calories")! as! Double)) kcal"
        } catch {
            fatalError("error appear when fetching")
        }
    }
    
    func addGradient() {
        let layer = CAGradientLayer()
        layer.frame = self.view.bounds
        layer.colors = [UIColor.blackColor().colorWithAlphaComponent(0.6).CGColor, UIColor.blackColor().colorWithAlphaComponent(0.4).CGColor]
        view.layer.insertSublayer(layer, atIndex: 0)
        //clearcolor
    }

}