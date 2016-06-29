//
//  BikeModelHelper.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/6/17.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//


import CoreLocation
import SwiftyJSON

struct YoubikeModelHelper { }
  

// MARK: - JSONParsable

extension YoubikeModelHelper {
    
    struct JSONKey {
        
        static let Identifier = "sno"
        
        static let Name = "sna"
        static let EnglishName = "snaen"
        
        static let Location = "ar"
        static let EnglishLocation = "aren"
        
        static let District = "sarea"
        static let EnglishDistrict = "sareaen"
        
        static let Latitude = "lat"
        static let Longitude = "lng"
        static let BikeRemain = "sbi"
        static let UpdateTime = "mday"
    }
    
    enum JSONError: ErrorType {
        
        case MissingIdentifier,
        
        MissingName,
        MissingEnglishName,
        
        MissingLocation,
        MissingEnglishLocation,
        
        MissingDistrict,
        MissingEnglishDistrict,
        
        MissingLatitude,
        MissingLongitude,
        MissingBikeRemain,
        MissingUpdateTime
    }
    
    func parse(json json: JSON) throws -> BikeModel {
        
        let numberFormatter = NSNumberFormatter()
        
        guard let identifier = json[JSONKey.Identifier].string else { throw JSONError.MissingIdentifier }
        
        guard let name = json[JSONKey.Name].string else { throw JSONError.MissingName }
        
        guard let location = json[JSONKey.Location].string else { throw JSONError.MissingLocation }
        
        guard let district = json[JSONKey.District].string else { throw JSONError.MissingDistrict }
        
        guard let latitudeString = json[JSONKey.Latitude].string else { throw JSONError.MissingLatitude }
        let latitude = numberFormatter.numberFromString(latitudeString) as? Double ?? 0.0
        
        guard let longitudeString = json[JSONKey.Longitude].string else { throw JSONError.MissingLongitude }
        let longitude = numberFormatter.numberFromString(longitudeString) as? Double ?? 0.0
    
        
        guard let bikeRemainString = json[JSONKey.BikeRemain].string else { throw JSONError.MissingBikeRemain }
        let bikeRemain = numberFormatter.numberFromString(bikeRemainString) as? Int ?? 0
        
        let youbike = BikeModel (
            identifier: identifier,
            coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            name: name,
            location: location,
            district: district
            
        )
        
        return youbike
    }
    
    
    
    
}