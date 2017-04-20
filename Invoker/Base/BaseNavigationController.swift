//
//  BaseNavigationController.swift
//  Wecube
//
//  Created by Tommy on 2016/11/23.
//  Copyright © 2016年 Tommy. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
        configBasicSetup()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - 导航栏样式
extension BaseNavigationController {
    func configBasicSetup() {
        
    }
}

// MARK: - 状态栏样式
extension BaseNavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController!.preferredStatusBarStyle
    }
}

// MARK: - 统一返回键设置
extension BaseNavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            let backBtn = UIButton(type: .custom)
            backBtn.addTarget(self, action: #selector(onClickBackAction(button:)), for: .touchUpInside)
            backBtn.sizeToFit()
            
            let leftItem = UIBarButtonItem(customView: backBtn)
            viewController.navigationItem.leftBarButtonItem = leftItem
            
            super.push(to: viewController)
        }
    }
    
    func onClickBackAction(button: UIButton) -> Void {
        
        popVC()
    }
}

// MARK: - 侧滑手势
extension BaseNavigationController : UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return childViewControllers.count > 1
    }
}

