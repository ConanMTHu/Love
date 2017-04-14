//
//  Dictionary+Tommy.swift
//  Wecube
//
//  Created by Tommy on 16/9/27.
//  Copyright © 2016年 Tommy. All rights reserved.
//

import Foundation

extension Dictionary {
    public func isHas(key: Key) -> Bool {
        return index(forKey: key) != nil
    }
}

public func += <KeyType, ValueType> (left: inout Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}
