//
//  RunDataModel.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/6/17.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//

import Foundation
import CoreData


class RunDataModel {
    
    class runDataStruct {
        var date: NSDate?
        var distance: Double?
        var speed: Double?
        var calories: Double?
        var time: String?
        var polyline: NSData?
    }
    
    private let context = DataController().managedObjectContext
    var runDataStructArray: [runDataStruct] = []
    
    
    func getData() -> [runDataStruct] {
        do {
            let getRequest = NSFetchRequest(entityName: "Record")
            let sortDesriptor = NSSortDescriptor(key: "timestamp", ascending: true)
            getRequest.sortDescriptors = [sortDesriptor]
            
            let data = try context.executeFetchRequest(getRequest)
            runDataStructArray = [] //reset
            for eachData in data {
                let _tempStruct = runDataStruct()
                _tempStruct.date = eachData.valueForKey("timestamp")! as? NSDate
                _tempStruct.distance = eachData.valueForKey("distance")! as? Double
                _tempStruct.speed = eachData.valueForKey("averageSpeed")! as? Double
                _tempStruct.calories = eachData.valueForKey("calories")! as? Double
                _tempStruct.time = eachData.valueForKey("timestamp")! as? String
                _tempStruct.polyline = eachData.valueForKey("path")! as? NSData
                runDataStructArray.append(_tempStruct)
            }
            
            return runDataStructArray
        } catch {
            fatalError("error appear when fetching")
        }
    }
    
}
