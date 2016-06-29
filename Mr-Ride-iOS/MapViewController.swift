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
    enum PickerViewStatus { case Toilets, Youbikes }
    var pickerViewStatus: PickerViewStatus = .Toilets
    @IBOutlet weak var pickerViewBackground: UIView!
    @IBOutlet weak var pickerViewButton: UIButton!
    @IBOutlet weak var sideMenuButton: UIBarButtonItem!
    
    // Info View Property
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var stationLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var estimatedTimeLabel: UILabel!
    
    var pickerView = UIPickerView()
    var pickerViewDataSource = ["Toilet", "YouBike"]
    
    
    // Map View Property
    @IBOutlet weak var mapView: GMSMapView!
    
    var locationManager = CLLocationManager()

    @IBAction func pickerViewButton(sender: UIButton) {
        pickerViewStatus = .Toilets
        pickerViewBackground.hidden = false
    }
    
    @IBAction func pickerViewDoneButton(sender: AnyObject) {
        pickerViewStatus = .Youbikes
        pickerViewBackground.hidden = true
    }
    

    
}

// MARK: - View Life Cycle

extension MapViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        setupPickerView()
        setupSideMenu()
        getToilets()
        setupToiletMarker()
    }
}

// MARK : - Setup
extension MapViewController {
    func setupMap(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        pickerView.delegate = self
        infoView.hidden = true
        pickerViewStatus = .Toilets
    }
    
    func setupPickerView() {
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.backgroundColor = UIColor.whiteColor()
        self.pickerView.frame = CGRectMake(0, 44, 375, 217)
        pickerViewBackground.addSubview(pickerView)
        pickerViewBackground.hidden = true
    }
    
    func setupSideMenu() {
        if self.revealViewController() != nil {
            sideMenuButton.target = self.revealViewController()
            sideMenuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
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
        mapView.clear()
        var toiletIndex = 0
        for toilet in toilets {
            let position = toilet.coordinate
            let marker = GMSMarker(position: position)
            marker.iconView = setupMarkerBackground("icon-toilet")
            marker.title = "\(toilet.name)"
            marker.map = mapView
            
            marker.userData = toiletIndex
            toiletIndex += 1
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
        mapView.clear()
        var bikeIndex = 0
        for bike in bikes {
            let position = bike.coordinate
            let marker = GMSMarker(position: position)
            marker.iconView = setupMarkerBackground("icon-station")
            marker.title = "\(bike.name)"
            marker.map = mapView
            
            marker.userData = bikeIndex
            bikeIndex += 1
        }
    }
    
    func setupMarkerBackground(icon: String) -> UIView {
        
        let iconImage = UIImage(named: icon)
        let tintedImage = iconImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        let iconImageView = UIImageView(image: tintedImage!)
        iconImageView.tintColor = .MRDarkSlateBlueColor()
        
        let markerBackground = UIView()
        markerBackground.backgroundColor = .whiteColor()
        markerBackground.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        markerBackground.layer.cornerRadius = markerBackground.frame.width / 2
        markerBackground.clipsToBounds = true
        
        markerBackground.addSubview(iconImageView)
        iconImageView.center = markerBackground.center
        
        return markerBackground
    }
    
}

// MARK: - Map View Delegate
extension MapViewController: GMSMapViewDelegate {
    func mapView(mapView: GMSMapView, didTapMarker marker: GMSMarker) -> Bool {
        infoView.hidden = false
        pickerViewBackground.hidden = true
        
        switch pickerViewStatus {
            
        case .Youbikes:
            guard let youbike = marker.userData as? Int else { return false }
            districtLabel.hidden = false
            districtLabel.text = bikes[youbike].district
            districtLabel.layer.borderColor = UIColor.whiteColor().CGColor
            districtLabel.layer.borderWidth = 0.7
            locationLabel.hidden = false
            
            stationLabel.text = bikes[youbike].name
            locationLabel.text = bikes[youbike].location
            estimatedTimeLabel.text = "5 mins"
            marker.userData = youbike
            
            
            
        case .Toilets:
            guard let toilet = marker.userData as? Int else { return false }
            districtLabel.hidden = true
            stationLabel.text = toilets[toilet].name
            locationLabel.hidden = true
            estimatedTimeLabel.text = "5 mins"
        }

        return false
        
    }
    
    func mapView(mapView: GMSMapView, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        infoView.hidden = true
        pickerViewBackground.hidden = true
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
            setupToiletMarker()
        case 1:
            getBikes()
            setupBikeMarker()
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
        
        //locationManager.stopUpdatingLocation()
    }
}