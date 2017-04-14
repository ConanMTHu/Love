//
//  TyRegular.swift
//  Wecube
//
//  Created by Tommy on 2016/12/8.
//  Copyright © 2016年 Tommy. All rights reserved.
//

import UIKit

public enum RegularExpression: String {
    case idCard = "^(\\d{14}|\\d{17})(\\d|[xX])$"
    case mail = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
    case ipAddress = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
    enum Mobile: String {
        case mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        case cm = "^1(34[0-8]|(3[5-9]|47|5[0127-9]|78|8[23478])\\d)\\d{7}$" // 中国移动
        case cu = "^1(3[0-2]|45|5[56]|7[156]|8[56])\\d{8}$"                 // 中国联通
        case ct = "^1((33|53|7[37]|8[019])[0-9]|349)\\d{7}$"                // 中国电信
        case other = "^1(70[0-9])\\d{7}$"
    }
}

private struct RegexHelper {
    let regex: NSRegularExpression
    
    init(_ pattern: String) throws {
        try regex = NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    }
    
    func match(_ input: String) -> Bool {
        let matches = regex.matches(in: input, options: [], range: NSMakeRange(0, input.utf16.count))
        return matches.count > 0
    }
}

// Swift3.0 xcode8 beta6 之后的写法
// 可以参考这个链接 http://stackoverflow.com/documentation/swift/1048/advanced-operators/23548/precedence-of-standard-swift-operators#t=201612060254337482352
precedencegroup MatchPrecedence {
    associativity: none
    higherThan: DefaultPrecedence
}
//中位操作符,前后都是输入
infix operator ~=~: MatchPrecedence
public func ~=~(object: String, template: String) -> Bool {
    do {
        return try RegexHelper(template).match(object)
    } catch _ {
        return false
    }
}

extension String {
    public func isMobile() -> Bool {
        if (self ~=~ RegularExpression.Mobile.mobile.rawValue) || (self ~=~ RegularExpression.Mobile.cm.rawValue) || (self ~=~ RegularExpression.Mobile.cu.rawValue) || (self ~=~ RegularExpression.Mobile.ct.rawValue) || (self ~=~ RegularExpression.Mobile.other.rawValue) {
            return true
        } else {
            return false
        }
    }
    
    public func toMobileProvider() -> String {
        if self ~=~ RegularExpression.Mobile.cm.rawValue {
            return "中国移动"
        } else if self ~=~ RegularExpression.Mobile.cu.rawValue {
            return "中国联通"
        } else if self ~=~ RegularExpression.Mobile.ct.rawValue {
            return "中国电信"
        } else {
            return "未知"
        }
    }
    
    public func isIdCard() -> Bool {
        return self ~=~ RegularExpression.idCard.rawValue
    }
    
    // MARK: - 判断是否是银行卡
    public func isBankCard() -> Bool {
        var oddSum = 0      // 奇数求和
        var evenSum = 0     // 偶数求和
        var allSum = 0
        let cardNoLength = self.length
        let lastNum = self.suffix(with: 1).toInt()
        let newCardNo = self.prefix(with: cardNoLength - 1)
        
        let range = 1...(cardNoLength - 1)
        for i in range.reversed() {
            let tmpString = newCardNo[i-1..<i]
            var tmpVal = tmpString.toInt()
            if cardNoLength % 2 == 1 {
                if i % 2 == 0 {
                    tmpVal *= 2
                    if tmpVal >= 10 {
                        tmpVal -= 9
                    }
                    evenSum += tmpVal
                } else {
                    oddSum += tmpVal
                }
            } else {
                if i % 2 == 1 {
                    tmpVal *= 2
                    if tmpVal >= 10 {
                        tmpVal -= 9
                    }
                    evenSum += tmpVal
                } else {
                    oddSum += tmpVal
                }
            }
        }
        allSum = oddSum + evenSum
        allSum += lastNum
        if allSum % 10 == 0 {
            return true
        } else {
            return false
        }
    }
}


