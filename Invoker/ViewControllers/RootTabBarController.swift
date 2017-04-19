//
//  RootTabBarController.swift
//  Invoker
//
//  Created by Tommy on 2017/4/14.
//  Copyright © 2017年 Tommy. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = .black
        
        guard let vcList = self.viewControllers else {
            return
        }
        
        let billVC = vcList[0]
        billVC.tabBarItem.selectedImage = UIImage(named: "tabbar_accountbook_highlight")?.withRenderingMode(.alwaysOriginal)
        
        let mineVC = vcList[1]
        mineVC.tabBarItem.selectedImage = UIImage(named: "tabbar_mine_highlight")?.withRenderingMode(.alwaysOriginal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
}
