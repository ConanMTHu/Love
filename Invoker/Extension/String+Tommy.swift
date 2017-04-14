//
//  String+Wecube.swift
//  Wecube
//
//  Created by Tommy on 16/9/26.
//  Copyright © 2016年 Tommy. All rights reserved.
//

import UIKit

// MARK: - 类型转换
extension String {
    public var length: Int {
        return self.characters.count
    }
    
    public func toInt() -> Int {
        guard let num = NumberFormatter().number(from: self) else {
            return 0
        }
        return num.intValue
    }
    
    public func toDouble() -> Double {
        guard let num = NumberFormatter().number(from: self) else {
            return 0.0;
        }
        return num.doubleValue
    }
    
    public func toFloat() -> Float {
        guard let num = NumberFormatter().number(from: self) else {
            return 0.0
        }
        return num.floatValue
    }
    
    init?(base64: String) {
        let pad = String(repeating: "=", count: base64.length % 4)
        let base64Padded = base64 + pad
        if let decodedData = Data(base64Encoded: base64Padded, options: NSData.Base64DecodingOptions(rawValue: 0)), let decodedString = NSString(data: decodedData, encoding: String.Encoding.utf8.rawValue) {
            self.init(decodedString)
            return
        }
        return nil
    }
    
    var base64: String {
        let plainData = (self as NSString).data(using: String.Encoding.utf8.rawValue)
        let base64String = plainData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64String
    }
    
    public mutating func urlDecode() {
        self = removingPercentEncoding ?? self
    }
    
    public mutating func urlEncode() {
        self = addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
}

// MARK: - 截取/去空格/替换/......
extension String {
    // 获取结尾 offset 个字符子串
    public func suffix(with length: Int) -> String {
        if length > self.length {
            return self
        }
        let index = self.index(self.endIndex, offsetBy: length * -1)
        return self.substring(from: index)
    }
    
    // 获取开头 offset 个字符子串
    public func prefix(with length: Int) -> String {
        if length > self.length {
            return self
        }
        let index = self.index(self.startIndex, offsetBy: length)
        return self.substring(to: index)
    }
    
    public subscript(integerRange: Range<Int>) -> String {
        let start = characters.index(startIndex, offsetBy: integerRange.lowerBound)
        let end = characters.index(startIndex, offsetBy: integerRange.upperBound)
        return self[start..<end]
    }
    
    public mutating func trim() {
        self = self.trimmed()
    }
    
    public func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public func split(_ separator: String) -> [String] {
        return self.components(separatedBy: separator).filter {
            !$0.trimmed().isEmpty
        }
    }
    
    public func includesEmoji() -> Bool {
        for i in 0...length {
            let c: unichar = (self as NSString).character(at: i)
            if (0xD800 <= c && c <= 0xDBFF) || (0xDC00 <= c && c <= 0xDFFF) {
                return true
            }
        }
        return false
    }
    
    public func rangeFromNSRange(_ nsRange: NSRange) -> Range<String.Index>? {
        let from16 = utf16.startIndex.advanced(by: nsRange.location)
        let to16 = from16.advanced(by: nsRange.length)
        if let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self) {
            return from ..< to
        } 
        return nil
    }
    
    public func matchesForRegexInText(_ regex: String!) -> [String] {
        let regex = try? NSRegularExpression(pattern: regex, options: [])
        let results = regex?.matches(in: self, options: [], range: NSRange(location: 0, length: self.length)) ?? []
        return results.map { self.substring(with: self.rangeFromNSRange($0.range)!) }
    }
    
    public func replacing(_ substring: String, with newString: String) -> String {
        return replacingOccurrences(of: substring, with: newString)
    }
}

// MARK: - 时间相关
extension String {
    public var date: Date? {
        let selfLowercased = self.trimmed().lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: selfLowercased)
    }
    
    public var dateTime: Date? {
        let selfLowercased = self.trimmed().lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: selfLowercased)
    }
    
    public func toDate(by dateFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: self)
        return date
    }
}

// MARK: - 打电话
extension String {
    func call() {
        let callWebView = UIWebView()
        callWebView.loadRequest(URLRequest(url: URL(string: "tel:" + self)!))
        App.lastWindow.addSubview(callWebView)
    }
}

// MARK: - 沙盒路径集合
// http://stackoverflow.com/questions/32501627/stringbyappendingpathcomponent-is-unavailable
// http://stackoverflow.com/questions/32120581/stringbyappendingpathcomponent-is-unavailable
public extension String {
    public var nsString: NSString {
        return NSString(string: self)
    }
    
    public var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
    
    public var pathExtension: String {
        return (self as NSString).pathExtension
    }
    
    public var deletingLastPathComponent: String {
        return (self as NSString).deletingLastPathComponent
    }
    
    public var deletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }
    
    public var pathComponents: [String] {
        return (self as NSString).pathComponents
    }
    
    public func appendingPathComponent(_ str: String) -> String {
        return (self as NSString).appendingPathComponent(str)
    }
    
    public func appendingPathExtension(_ str: String) -> String? {
        return (self as NSString).appendingPathExtension(str)
    }
    
}
