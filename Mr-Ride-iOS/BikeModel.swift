//
//  BikeModel.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/6/13.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//

import Foundation
import CoreLocation

class BikeModel {
    
    let identifier: String
    let coordinate: CLLocationCoordinate2D
    let name: String
    let location: String
    let district: String
    
    init(identifier: String, coordinate: CLLocationCoordinate2D, name: String, location: String, district: String){
        
        self.identifier = identifier
        self.coordinate = coordinate
        self.name = name
        self.location = location
        self.district = district
        
    }
}