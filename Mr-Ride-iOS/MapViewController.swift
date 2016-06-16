//
//  MapViewController.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/6/14.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, UIPickerViewDataSource {
    var toilets: [ToiletModel] = []

    // Picker View Property
    @IBOutlet weak var pickerViewBackground: UIView!
    @IBOutlet weak var pickerViewButton: UIButton!
    
    var pickerView = UIPickerView()
    var pickerViewDataSource = ["Toilet", "YouBike"]

    
    // Map View Property
    @IBOutlet weak var mapView: GMSMapView!
    
    var locationManager = CLLocationManager()

    @IBAction func pickerViewButton(sender: UIButton) {
        pickerViewBackground.hidden = false
    }

}

// MARK: - View Life Cycle

extension MapViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        setupPickerView()
        setupToiletMarker()
        getToilet()
        setupToiletMarker()
    }
    
    override func viewWillAppear(animated: Bool) {
        print("2")
    }
}

// MARK : - Setup
extension MapViewController {
    func setupPickerView() {
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.backgroundColor = UIColor.whiteColor()
        self.pickerView.frame = CGRectMake(0, 44, 375, 217)
        pickerViewBackground.addSubview(pickerView)
        pickerViewBackground.hidden = true
    }
}

// MARK: - Action

extension MapViewController {
    func getToilet() {
        let manager = DataTaipeiManager()
        manager.getToilet({ [weak self] toilets in
            guard let weakSelf = self else { return }
            
            weakSelf.toilets = toilets
            weakSelf.setupToiletMarker()
            print("1")
            
            }, failure: {error in print(error)})
    }
    
    func setupToiletMarker() {
//        for toiletCoordinate in toilets {
//            let position = CLLocationCoordinate2D(toiletCoordinate.coordinate)
//            let toilet = GMSMarker(position: position)
//            toilet.title = "Toilet"
//            toilet.icon = UIImage(named: "icon-toilet")
//            toilet.map = mapView
//            print("in for in")
//            print(toiletCoordinate.coordinate)
//        }

        mapView.clear()
        
        var toiletIndex = 0
        for toilet in toilets {
            let  position = toilet.coordinate
            let marker = GMSMarker(position: position)
            marker.icon = UIImage(named: "icon-toilet")
            //marker.title = "\(toilet.location)"
            marker.userData = toiletIndex
            marker.map = mapView
            
            toiletIndex += 1
        }
    }
}

// MARK: - GoogleMapSDK



// MARK: - UIPickerViewDelegate

extension MapViewController: UIPickerViewDelegate {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewDataSource.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        return pickerViewDataSource[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(row == 0)
        {
            self.view.backgroundColor = UIColor.whiteColor();
        }
        else if(row == 1)
        {
            self.view.backgroundColor = UIColor.redColor();
        } else
        {
            self.view.backgroundColor = UIColor.blueColor();
        }
    }
}

// MARK: - CLLocationManager

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        }
    }
}
