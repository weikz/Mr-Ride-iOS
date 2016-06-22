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
    var bikes: [BikeModel] = []

    // Picker View Property
    enum PickerViewStatus { case Toilets, Youbike }
    var pickerViewStatus: PickerViewStatus = .Toilets
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
    
    @IBAction func pickerViewDoneButton(sender: AnyObject) {
        pickerViewBackground.hidden = true
    }
    

    
}

// MARK: - View Life Cycle

extension MapViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        setupPickerView()
        getToilets()
        getBikes()
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
    func getToilets() {
        let manager = DataTaipeiManager()
        manager.getToilet({ [weak self] toilets in
            guard let weakSelf = self else { return }

            weakSelf.toilets = toilets
            weakSelf.setupToiletMarker()
            
            }, failure: {error in print(error)})
    }
    
    func setupToiletMarker() {
        for toilet in toilets {
            let position = toilet.coordinate
            let marker = GMSMarker(position: position)
            marker.icon = UIImage(named: "icon-toilet")
            marker.title = "\(toilet.name)"
            marker.map = mapView
        }
    }
    
    func getBikes() {
        let manager = DataTaipeiManager()
        manager.getBike({ [weak self] bikes in
            guard let weakSelf = self else { return }
            
            weakSelf.bikes = bikes
            weakSelf.setupBikeMarker()
            
            }, failure: { error in print(error)})
    }
    
    func setupBikeMarker() {
        for bike in bikes {
            let position = bike.coordinate
            let marker = GMSMarker(position: position)
            marker.icon = UIImage(named: "icon-station")
            marker.title = "\(bike.name)"
            marker.map = mapView
            print(bike.name)
        }
    }
}




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
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            // toilets
            print("todo: 0")
        case 1:
            // youbikes
            print("todo: 1")
        default: break
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
