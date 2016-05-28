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
    @IBOutlet weak var googleMapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
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
        if let location = locations.first {
            
            googleMapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            // draw polylines
            let path = GMSMutablePath()
            path.addCoordinate(location.coordinate)
            
            let polyline = GMSPolyline(path: path)
            polyline.strokeColor = UIColor.blueColor()
            polyline.strokeWidth = 10.0
            polyline.geodesic = true
            polyline.map = googleMapView

        }

        
    }
    
}