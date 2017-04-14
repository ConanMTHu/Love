//
//  CGFloat+Tommy.swift
//  Wecube
//
//  Created by Tommy on 2016/11/22.
//  Copyright © 2016年 Tommy. All rights reserved.
//

import UIKit

// MARK: - 角度与弧度之前的转换关系
extension CGFloat {
    
    public func degreesToRadians() -> CGFloat {
        return (.pi * self) / 180.0
    }
    
    public mutating func toRadiansInPlace() {
        self = (.pi * self) / 180.0
    }
    
    public static func degreesToRadians(_ angle: CGFloat) -> CGFloat {
        return (.pi * angle) / 180.0
    }
    
    public func radiansToDegrees() -> CGFloat {
        return (180.0 * self) / .pi
    }
    
    public mutating func toDegreesInPlace() {
        self = (180.0 * self) / .pi
    }
    
    public static func radiansToDegrees(_ angleInDegrees: CGFloat) -> CGFloat {
        return (180.0 * angleInDegrees) / .pi
    }
}
