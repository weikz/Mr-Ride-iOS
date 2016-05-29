//
//  buttonPlayAndPause.swift
//  Mr-Ride-iOS
//
//  Created by 張瑋康 on 2016/5/26.
//  Copyright © 2016年 Appworks School Weikz. All rights reserved.
//

import UIKit

class buttonPlayAndPause: UIButton {
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        UIColor.redColor().setFill()
        path.fill()
    }
}
