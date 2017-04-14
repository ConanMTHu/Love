//
//  CAShapeLayer+Tommy.swift
//  Wecube
//
//  Created by Tommy on 2016/11/23.
//  Copyright © 2016年 Tommy. All rights reserved.
//

import UIKit

extension CAShapeLayer {
    public func drawOval(in rect: CGRect, fillColor: UIColor, strokeColor: UIColor = UIColor.clear, lineWidth: CGFloat) {
        let path = UIBezierPath(ovalIn: rect)
        self.path = path.cgPath
        self.fillColor = fillColor.cgColor
        self.strokeColor = strokeColor.cgColor
        self.lineWidth = lineWidth
    }
}
