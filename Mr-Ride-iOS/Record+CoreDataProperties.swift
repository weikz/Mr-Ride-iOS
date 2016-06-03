//
//  Record+CoreDataProperties.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/6/1.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Record {

    @NSManaged var averageSpeed: NSNumber?
    @NSManaged var calories: NSNumber?
    @NSManaged var distance: NSNumber?
    @NSManaged var duration: NSNumber?
    @NSManaged var path: NSObject?
    @NSManaged var timestamp: NSDate?

}
