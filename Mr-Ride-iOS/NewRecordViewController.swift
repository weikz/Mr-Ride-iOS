//
//  NewRecordViewController.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/5/24.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//

import UIKit
import GoogleMaps

class NewRecordViewController: UIViewController {
  
    let locationManager = CLLocationManager()
    var paceTimer: NSTimer!
    var paceCounter = 0
    
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var distance = 0.0
    
    var pathArray: [CLLocation] = []


    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var averageSpeedLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    @IBAction func playAndPauseButton(sender: UIButton) {
        paceTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }

    @IBOutlet weak var googleMapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        timerLabel.text = String(paceCounter)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addGradient() {
        let layer = CAGradientLayer()
        layer.frame = self.view.bounds
        layer.colors = [UIColor.blackColor().colorWithAlphaComponent(0.6).CGColor, UIColor.blackColor().colorWithAlphaComponent(0.4).CGColor]
        view.layer.insertSublayer(layer, atIndex: 0)
    }
    
    func runTimedCode() {
        timerLabel.text = String(paceCounter++)
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
        
        
        // Be careful!!!!
        // check timestamp
        // call 500 times instead of 1000? hint: NSTimer
        
        // prevent from too many polylines
        googleMapView.clear()
       
        
        // set distance/average speed ( distance / time )
        if startLocation == nil {
            startLocation = locations.first
        } else {
            if let lastLocation = locations.last {
                let distance = startLocation.distanceFromLocation(lastLocation)

                distanceLabel.text = String(distance)
                
//                let lastDistance = lastLocation.distanceFromLocation(lastLocation)
//                traveledDistance += lastDistance

                
                
            }
        }
        
        
        
        // set Calories
        
        
        
        if let location = locations.first {
            
            pathArray.append(location)
            print("my array count:\(pathArray.count)")
            print("didUpdateLocations array count:\(locations.count)")
            
            
            googleMapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
            // draw polylines
            let path = GMSMutablePath()
            
            for paths in pathArray {
                path.addCoordinate(paths.coordinate)
            }
            
            let polyline = GMSPolyline(path: path)
            polyline.strokeColor = UIColor.blueColor()
            polyline.strokeWidth = 10.0
            polyline.geodesic = true
            polyline.map = googleMapView
        }

        
    }
    
}

