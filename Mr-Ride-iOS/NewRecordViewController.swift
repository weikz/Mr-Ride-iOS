//
//  NewRecordViewController.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/5/24.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreData

class NewRecordViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var integerHeight = 0.0
    var integerWeight = 0.0
    
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var distance = 0.0
    var calories = 0.0
    
    var durationString = ""
    var timer = NSTimer()
    var minutes = 0
    var seconds = 0
    var fractions = 0
    var startTracking = false
    
    var pathArray: [CLLocation] = []
    var pathArrayForCoreData: [CLLocation] = []
    var pathArrayFor: [Dictionary<String, AnyObject>] = []
    
    var averageSpeed:Double = 0.0
    
    let context = DataController().managedObjectContext
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var averageSpeedLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    @IBAction func playAndPauseButton(sender: UIButton) {
        if startTracking == false {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(NewRecordViewController.playAndPauseSelector), userInfo: nil, repeats: true)
            startTracking = true
        } else {
            timer.invalidate()
        }
    }
    
    @IBOutlet weak var googleMapView: GMSMapView!
    @IBAction func finishButton(sender: UIButton) {
        getPathArray()
        getAverageSpeed()
        saveDataToCoreData()
        performSegueWithIdentifier("toStatisticPage", sender: nil)
    }
}

// MARK: - View Life Cycle

extension NewRecordViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        
        // caculate cal
        if let userHeightForCaculateCalories = defaults.objectForKey("userHeight") as? String {
            integerHeight = Double(userHeightForCaculateCalories)!
        }
        if let userWeightForCaculateCalories = defaults.objectForKey("userWeight") as? String {
            integerWeight = Double(userWeightForCaculateCalories)!
        }
    }
}

// MARK: - Setup

extension NewRecordViewController {
    func addGradient() {
        let layer = CAGradientLayer()
        layer.frame = self.view.bounds
        layer.colors = [UIColor.blackColor().colorWithAlphaComponent(0.6).CGColor, UIColor.blackColor().colorWithAlphaComponent(0.4).CGColor]
        view.layer.insertSublayer(layer, atIndex: 0)
    }
}

// MARK: - Setup Timer

extension NewRecordViewController {
    func playAndPauseSelector() {
        fractions += 1
        if fractions == 100 {
            seconds += 1
            fractions = 0
        }
        
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        
        let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        durationString = "\(minutesString):\(secondString).\(fractionsString)"
        timerLabel.text = durationString
    }
}


// MARK: - CLLocationManagerDelegate

extension NewRecordViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            
            googleMapView.myLocationEnabled = true
            googleMapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        googleMapView.clear()

        if startLocation == nil {
            startLocation = locations.first
        } else {
            if let lastLocation = locations.last {

                distance = startLocation.distanceFromLocation(lastLocation)
                
                distanceLabel.text = String(round(100.0 * distance) / 100.0) + " m"

                averageSpeedLabel.text = String(round(100.0 * lastLocation.speed) / 100.0) + " km/h"
                
                calories = distance * integerHeight * integerWeight * 0.05
                
                caloriesLabel.text = String(round(100.0 * calories) / 100.0) + " cal"
            }
        }
        
        if let location = locations.first {
            
            pathArray.append(location)
            googleMapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            // draw polylines
            let path = GMSMutablePath()
            
            for paths in pathArray {
                path.addCoordinate(paths.coordinate)
            }
            
            let polyline = GMSPolyline(path: path)
            polyline.strokeColor = UIColor.blueColor()
            polyline.strokeWidth = 6.0
            polyline.geodesic = true
            polyline.map = googleMapView
        }
    }
}

// MARK: - Save in Core Data

extension NewRecordViewController {
    func getPathArray() -> NSData {
        for location in pathArrayForCoreData {
            let latitude = NSNumber(double: Double(location.coordinate.latitude))
            let longitude = NSNumber(double: Double(location.coordinate.longitude))
            let coordinate = ["latitude": latitude, "logitude": longitude]
            pathArrayFor.append(coordinate)
        }
        let _polylineCoordinatePackage = NSKeyedArchiver.archivedDataWithRootObject(pathArrayFor)
        
        return _polylineCoordinatePackage
    }
    
    func getAverageSpeed() -> Double{
        for location in pathArrayForCoreData {
            averageSpeed += Double(location.speed)
        }
        averageSpeed = averageSpeed / Double(pathArrayForCoreData.count)
        return averageSpeed
    }
    
    func saveDataToCoreData() {
        if let record = NSEntityDescription.insertNewObjectForEntityForName("Record", inManagedObjectContext: context) as? Record {
          
            record.timestamp = NSDate()
            record.distance = distance
            record.averageSpeed = 6
            record.calories = calories
            record.path = getPathArray()
        }
        
        context.performBlock{
            do {
                try self.context.save()
            } catch{
                fatalError("Failure to save context.")
            }
        }
    }
}

