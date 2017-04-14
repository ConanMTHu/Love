//
//  ConstDataService.swift
//  Wecube
//
//  Created by Tommy on 2016/12/29.
//  Copyright © 2016年 Tommy. All rights reserved.
//

import Foundation

// MARK: - 网络请求的 BaseUrl 配置
enum EnvironmentStatus: String {
    case developer = "developer"
    case preRelease = "preRelease"
    case distribution = "distribution"
}

extension EnvironmentStatus {
    func baseUrl() -> String {
        switch self {
        case .developer:
            return "https://apptest.wecube.com/taojinjia/"
        case .preRelease:
            return "http://views.wecube.com/taojinjia/"
        case .distribution:
            return "http://app.weathouse.com:8080/taojinjia/"
        }
    }
}
