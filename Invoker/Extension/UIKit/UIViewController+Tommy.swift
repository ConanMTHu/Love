//
//  UIViewController+Tommy.swift
//  Wecube
//
//  Created by Tommy on 16/9/27.
//  Copyright © 2016年 Tommy. All rights reserved.
//

import UIKit

public enum ViewControllerJumpTargetStyle {
    case push
    case pop
    case popTo
    case present
    case dismiss
}

// MARK: - 自身业务
public extension UIViewController {
    public func open(action: ViewControllerJumpTargetStyle = .push, vc: UIViewController.Type, param: [String: Any]? = nil) {
        let storyboardID = String(describing: vc)
        let viewController = UIStoryboard(name: "Root", bundle: nil).instantiateViewController(withIdentifier: storyboardID)
        viewController.param = param
        switch action {
        case .push:
            push(to: viewController)
        case .popTo: print("")
        case .present: print("")
        case .dismiss: print("")
        default:
            popVC()
        }
    }
}

// MARK: - vc 之间的跳转传值通过一个 Dic 来实现
public extension UIViewController {
    private struct RuntimeKey {
        static let paramKey = UnsafeRawPointer.init(bitPattern: "paramKey".hashValue)
        /// ...其他Key声明
    }
    
    var param: [String: Any]? {
        set {
            objc_setAssociatedObject(self, UIViewController.RuntimeKey.paramKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return  objc_getAssociatedObject(self, UIViewController.RuntimeKey.paramKey) as? [String : Any]
        }
    }
}

// MARK: - flow
extension UIViewController {
    public func push(to vc: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(vc, animated: animated)
    }
    
    public func popVC(animated: Bool = true) {
        _ = navigationController?.popViewController(animated: animated)
    }
    
    public func popVC(to vc: UIViewController, animated: Bool = true) {
        _ = navigationController?.popToViewController(vc, animated: animated)
    }
    
    public func present(to vc: UIViewController, animated: Bool = true) {
        present(vc, animated: animated, completion: nil)
    }
    
    public func dismissVC(animated: Bool = true, completion: (() -> Void)? ) {
        dismiss(animated: animated, completion: completion)
    }
    
    public func addAsChildViewController(_ vc: UIViewController, toView: UIView) {
        self.addChildViewController(vc)
        toView.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
    }
}

// MARK: - 通知...偷懒
extension UIViewController {
    public func addNotificationObserver(name: String, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: NSNotification.Name(rawValue: name), object: nil)
    }
    
    public func removeNotificationObserver(name: String) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: name), object: nil)
    }
    
    public func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }
}
