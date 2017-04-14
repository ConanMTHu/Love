//
//  NSAttributedString+Tommy.swift
//  Wecube
//
//  Created by Tommy on 2016/11/23.
//  Copyright © 2016年 Tommy. All rights reserved.
//

import UIKit

public func += (left: inout NSAttributedString, right: NSAttributedString) {
    let ns = NSMutableAttributedString(attributedString: left)
    ns.append(right)
    left = ns
}
