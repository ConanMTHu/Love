//
//  Date+Tommy.swift
//  Wecube
//
//  Created by Tommy on 2016/11/23.
//  Copyright © 2016年 Tommy. All rights reserved.
//

import UIKit

extension Date {
    public init?(fromString string: String, format: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if let date = formatter.date(from: string) {
            self = date
        } else {
            return nil
        }
    }
    
    public func toString(dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self)
    }
    
    public func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    public func timePassed() -> String {
        let date = Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.year, .month, .day, .hour, .minute, .second], from: self, to: date, options: [])
        var str: String
        
        if components.year! >= 1 {
            components.year == 1 ? (str = "year") : (str = "years")
            return "\(String(describing: components.year)) \(str) ago"
        } else if components.month! >= 1 {
            components.month == 1 ? (str = "month") : (str = "months")
            return "\(String(describing: components.month)) \(str) ago"
        } else if components.day! >= 1 {
            components.day == 1 ? (str = "day") : (str = "days")
            return "\(String(describing: components.day)) \(str) ago"
        } else if components.hour! >= 1 {
            components.hour == 1 ? (str = "hour") : (str = "hours")
            return "\(String(describing: components.hour)) \(str) ago"
        } else if components.minute! >= 1 {
            components.minute == 1 ? (str = "minute") : (str = "minutes")
            return "\(String(describing: components.minute)) \(str) ago"
        } else if components.second == 0 {
            return "Just now"
        } else {
            return "\(String(describing: components.second)) seconds ago"
        }
    }
    
    public var isToday: Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        return format.string(from: self) == format.string(from: Date())
    }
    
    public var year: Int {
        return NSCalendar.current.component(Calendar.Component.year, from: self)
    }
    
    public var month: Int {
        return NSCalendar.current.component(Calendar.Component.month, from: self)
    }
    
    public var weekday: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    public var monthAsString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    
    public var day: Int {
        return NSCalendar.current.component(Calendar.Component.day, from: self)
    }
    
    public var hour: Int {
        return NSCalendar.current.component(Calendar.Component.hour, from: self)
    }
    
    public var minute: Int {
        return NSCalendar.current.component(Calendar.Component.minute, from: self)
    }
    
    public var second: Int {
        return NSCalendar.current.component(Calendar.Component.second, from: self)
    }
}

