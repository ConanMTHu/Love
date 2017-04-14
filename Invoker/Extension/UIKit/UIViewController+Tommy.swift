//
//  UIViewController+Tommy.swift
//  Wecube
//
//  Created by Tommy on 16/9/27.
//  Copyright © 2016年 Tommy. All rights reserved.
//

import UIKit

// MARK: - flow
extension UIViewController {
    public func push(to vc: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(vc, animated: animated)
    }
    
    public func popVC(animated: Bool = true) {
        _ = navigationController?.popViewController(animated: animated)
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
