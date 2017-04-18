//
//  StartService.swift
//  Wecube
//
//  Created by Tommy on 2016/10/31.
//  Copyright © 2016年 Tommy. All rights reserved.
//

import UIKit

extension AppDelegate {
    func startLoad() {
        // TODO: app服务器环境(上线的时候记得修改这里)
        Defaults[.environmentStatus] = .developer
        
        // TODO: 监测网络状况
        networkReachabilityManager?.startListening()
    }
}




