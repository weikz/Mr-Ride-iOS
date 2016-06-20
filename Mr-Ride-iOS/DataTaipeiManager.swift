//
//  DataTaipeiManager.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/6/13.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class DataTaipeiManager {
    typealias getToiletSuccess = (toilets: [ToiletModel]) -> Void
    typealias getToiletFailure = (error: ErrorType) -> Void
    
    func getToilet(success: getToiletSuccess, failure: getToiletFailure) -> Void {
        
        let URL = NSURL(string: "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=fe49c753-9358-49dd-8235-1fcadf5bfd3f")!
        let URLRequest = NSMutableURLRequest(URL: URL)
        let request = Alamofire.request(URLRequest).responseData { result in
            
            if let httpError = result.result.error {
                let statusCode = httpError.code
                print("getToilet http status code:\(statusCode), please fix it.")
            }

            
            switch result.result {
            case .Success(let data):
                let json = JSON(data: data)
                
                var toilets: [ToiletModel] = []
                
                for (_, tolet) in json["result"]["results"] {
                    
                    do {
                        let toilet = try ToiletModelHelper().parse(json: tolet)
                        
                        toilets.append(toilet)
                    }
                    catch(let error) {
                        print(error)
                        
                    }
                    
                }
                success(toilets:toilets)
            case .Failure(let err):
                // todo: print ErrorType
                print("errorType")
                failure(error: err)
                
            }
            
        }
    }
    
    typealias getBikeSuccess = (bikes: [BikeModel]) -> Void
    typealias getBikeFailure = (error: ErrorType) -> Void
    
    func getBike(success: getBikeSuccess, failure: getBikeFailure) -> Void {
        let URL = NSURL(string: "http://data.taipei/youbike")!
        let URLRequest = NSMutableURLRequest(URL: URL)
        let request = Alamofire.request(URLRequest).responseData { result in
            
            if let httpError = result.result.error {
                let statusCode = httpError.code
                print("getBike http status code:\(statusCode), please fix it.")
            }
            
            switch result.result {
            case .Success(let data):
                let json = JSON(data: data)
                
                var bikes: [BikeModel] = []
                
                for (_, bike) in json["retVal"]{
                    
                    do {
                        let tempbikes = try YoubikeModelHelper().parse(json: bike)
                        
                        bikes.append(tempbikes)
                        
                    }
                    catch(let error) {
                        print(error)
                        
                    }
                }
                
                success(bikes:bikes)
                
            case .Failure(let err):
                // todo: print ErrorType
                print("errorType")
                failure(error: err)
                
            }
        }
    }
}