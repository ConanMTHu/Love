//
//  Int+Tommy.swift
//  Wecube
//
//  Created by Tommy on 2016/11/23.
//  Copyright © 2016年 Tommy. All rights reserved.
//

import UIKit

extension Int {
    public var toDouble: Double { return Double(self) }
    
    public var toFloat: Float { return Float(self) }
    
    public var toCGFloat: CGFloat { return CGFloat(self) }
    
    public var toString: String { return String(self) }
    
    public var toUInt: UInt { return UInt(self) }
    
    public var toInt32: Int32 { return Int32(self) }
    
    public var isEven: Bool { return (self % 2) == 0 }
    
    public var isOdd: Bool { return (self % 2) != 0 }
    
    // SwifterSwift
    public var timeString: String {
        guard self > 0 else {
            return "0 sec"
        }
        if self < 60 {
            return "\(self) sec"
        }
        if self < 3600 {
            return "\(self / 60) min"
        }
        let hours = self / 3600
        let mins = (self % 3600) / 60
        
        if hours == 0 && mins != 0 {
            return "\(mins) min"
            
        } else if hours != 0 && mins == 0 {
            return "\(hours) h"
            
        } else {
            return "\(hours) h \(mins) m"
        }
    }
}
