//
//  JSONParsable.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/6/14.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//

import SwiftyJSON

protocol JSONParsable {
    
    associatedtype T
    
    func parse(json json: JSON) -> T
}