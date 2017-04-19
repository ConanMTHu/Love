//
//  AppInfo.swift
//  Wecube
//
//  Created by Tommy on 16/9/27.
//  Copyright © 2016年 Tommy. All rights reserved.
//

import Foundation
import UIKit

public struct App {
    public static var version: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    public static var build: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
    
    public static var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    public static var screenHeight: CGFloat { 
        return UIScreen.main.bounds.size.height
    }
    
    public static var lastWindow: UIWindow {
        let windows = UIApplication.shared.windows
        for window in windows.reversed() {
            if window.isKind(of: UIWindow.self), window.bounds.equalTo(UIScreen.main.bounds)  {
                return window
            }
        }
        return UIApplication.shared.keyWindow ?? UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    }
    
    public static var topView: UIView {
        if let topVC = App.topViewController() {
            return topVC.view
        } else {
            return App.lastWindow
        }
    }
    
    public static var isIphone5: Bool {
        if App.screenWidth == 320.0 {
            return true
        } else {
            return false
        }
    }
    
    public static var isIphone6: Bool {
        if App.screenWidth == 375.0 {
            return true
        } else {
            return false
        }
    }
    
    public static var isIphone6Plus: Bool {
        if App.screenWidth == 414.0 {
            return true
        } else {
            return false
        }
    }
    
    public static var isDebug: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    
    public static var isRelease: Bool {
        #if DEBUG
            return false
        #else
            return true
        #endif
    }
    
    public static var isSimulator: Bool {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return true
        #else
            return false
        #endif
    }
    
    public static var isDevice: Bool {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return false
        #else
            return true
        #endif
    }
    
    public static func runThisInMainThread(_ block: @escaping ()->()) {
        DispatchQueue.main.async(execute: block)
    }
    
    public static func runThisInBackground(_ block: @escaping () -> ()) {
        DispatchQueue.global(qos: .default).async(execute: block)
    }
    
    public static func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}

//封装的日志输出功能
func TYLog<T>(_ message:T, file:String = #file, function:String = #function,
           line:Int = #line) {
    #if DEBUG
        //获取文件名
        let fileName = (file as NSString).lastPathComponent
        //打印日志内容
        print("\(fileName):\(line) \(function) | \(message)")
    #endif
}
