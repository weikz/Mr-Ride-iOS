//
//  ToiletModelHelper.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/6/13.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//

import CoreLocation
import SwiftyJSON

struct ToiletModelHelper {}


// MARK: -JSONParsable

extension ToiletModelHelper {
    struct JSONKey {
        static let Identifier = "_id"
        static let Latitude = "Latitude"
        static let Longitude = "Longitude"
        static let Name = "Location"
    }

    enum JSONError: ErrorType {
        case MissingIdentifier, MissingLatidue, MissingLongitude, MissingName }
    
    func parse(json json: JSON) throws -> ToiletModel {
        
        guard let identifier = json[JSONKey.Identifier].string else {
            print("identifier not parsing")
            throw JSONError.MissingIdentifier
        }
        
        let numberFormatter = NSNumberFormatter()
        
        guard let latitudeString = json[JSONKey.Latitude].string else {
            print("latitude is missing")
            throw JSONError.MissingLatidue
        }
        let latitude = numberFormatter.numberFromString(latitudeString) as? Double ?? 0.0
        
        guard let longitudeString = json[JSONKey.Longitude].string else {
            print("longitude is missing")
            throw JSONError.MissingLongitude
        }
        let longitude = numberFormatter.numberFromString(longitudeString) as? Double ?? 0.0
        
        guard let name = json[JSONKey.Name].string else {
            print("name is missing")
            throw JSONError.MissingName
        }
        
        
        
        let toilet = ToiletModel (
            identifier: identifier,
            coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            name: name )
        
        print(toilet.name)
        return toilet
    }
}