//
//  UserDefaultsService.swift
//  Wecube
//
//  Created by Tommy on 2016/11/24.
//  Copyright © 2016年 Tommy. All rights reserved.
//

import SwiftyUserDefaults

let Defaults = UserDefaults(suiteName: "com.app.wecube")!

extension UserDefaults {
    subscript(key: DefaultsKey<EnvironmentStatus>) -> EnvironmentStatus {
        get { return unarchive(key) ?? .distribution } // 默认返回线上环境
        set { archive(key, newValue) }
    }
}

extension DefaultsKeys {
    static let environmentStatus = DefaultsKey<EnvironmentStatus>("environmentStatus")
}


