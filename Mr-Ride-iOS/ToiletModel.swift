//
//  ToiletModel.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/6/13.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//

import Foundation
import CoreLocation

class ToiletModel {
    
    let identifier: String
    let coordinate: CLLocationCoordinate2D
    let name: String
    
    
    init(identifier: String, coordinate: CLLocationCoordinate2D, name: String) {
        
        self.identifier = identifier
        self.coordinate = coordinate
        self.name = name
    }
    
}
