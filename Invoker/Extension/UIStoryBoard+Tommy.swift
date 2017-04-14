//
//  UIStoryBoard+Tommy.swift
//  Wecube
//
//  Created by Tommy on 16/9/27.
//  Copyright © 2016年 Tommy. All rights reserved.
//

import UIKit

public extension UIStoryboard {
    // 比如 T 代表了 UIViewController ,那么 T.Type 就是 要求传入 UIViewController这个类型的类型 也就是 UIViewController.self
    public static func instantiateVC<T>(by storyBoardName:StoryboardName, identifier: T.Type) -> T {
        let sb = UIStoryboard(name: storyBoardName.rawValue, bundle: nil)
        return sb.instantiateViewController(withIdentifier: String(describing: identifier)) as! T
    }
    
    public static func instantiateNavC(by storyBoardName:StoryboardName, identifier: String) -> UINavigationController {
        let sb = UIStoryboard(name: storyBoardName.rawValue, bundle: nil)
        return sb.instantiateViewController(withIdentifier: identifier) as! UINavigationController
    }
}

public enum StoryboardName: String {
    case root = "Root"
    case homePage = "HomePage"
}

