//
//  NetworkService.swift
//  Wecube
//
//  Created by Tommy on 2016/10/31.
//  Copyright © 2016年 Tommy. All rights reserved.
//

import Foundation
import Alamofire

public protocol RequestElementAble {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? {get}
}

public enum API {
    case login(loginName: String, password: String)  // 登录
    case registerCode(userMobile: String, verifyType: String, verifyCode: String)
    case checkIsRegister(userMobile: String) // 检查手机号码是否可以注册
    
    case queryBranchInvest  // 查询首页新手专享与月活期项目

    case mediaNews  // 查询淘金家播报
}

extension API: RequestElementAble {
    public var baseURL: String {
        switch self {
        case .mediaNews:
            return "https://www.taojinjia.com/Data/Json/1.json"
        default:
            return Defaults[.environmentStatus].baseUrl()
        }
    }
    
    public var headers: HTTPHeaders? {
        return ["x-requested-with": "mobile",
                "Content-Type": "application/json"]
    }

    public var path: String {
        switch self {
        case .login(_,_):
            return "services/crane/sso/login/doLogin"
        case .registerCode(_,_,_):
            return "services/crane/sso/login/registerCode"
        case .checkIsRegister(_):
            return "services/crane/sso/login/check"
        case .queryBranchInvest:
            return "services/creditor/product/fpCfg"
        case .mediaNews:
            return ""
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .queryBranchInvest,.mediaNews:
            return .get
        case .login(_,_),.registerCode(_,_,_), .checkIsRegister(_):
            return .post
        }
    }
    
    public var parameters: Parameters? {
        switch self {
        case let .login(loginName,password):
            return ["loginName": loginName, "userPassword": password]
        case let .registerCode(userMobile, verifyType, verifyCode):
            return ["userMobile" : userMobile, "verifyType" : verifyType, "verifyCode" : verifyCode]
        case let .checkIsRegister(userMobile):
            return ["userMobile" : userMobile]
        default:
            return nil
        }
    }
}

public typealias SuccessClosure<T> = (_ result: T) -> Void
public typealias FailClosure<T> = (_ error: T?) -> Void

extension API {
    var url: String {
        return self.baseURL.appending(self.path)
    }
    
    public func request<T>(success successCallBack: SuccessClosure<T>?, fail failCallBack: FailClosure<T>? = nil) {
        request(isNeedLoading: false, success: successCallBack, fail: failCallBack)
    }
    
    public func request<T>(isNeedLoading: Bool, success successCallBack: SuccessClosure<T>?, fail failCallBack: FailClosure<T>? = nil) {
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
        
            // fail(非200)
            guard let _ = response.response else {
                //TyAlertHUD.showErrorMessage(text: "网络连接错误,请检查您的网络情况")
                failCallBack?(nil)
                return;
            }
            
            guard let json = response.result.value as? [String : Any] else {
                failCallBack?(nil)
                return;
            }
            // success(200) 后台约定固定格式{"code": "xxx", "msg": "xxx", "data": "xxxx"} code等于1的时候才会返回data
            guard let code = json["code"] as? String, code == "1" else {
                //TyAlertHUD.showErrorMessage(text: (json["msg"] as? String) ?? "未知错误")
                failCallBack?(nil)
                return;
            }
            guard let data = json["data"] else {
                failCallBack?(nil)
                return;
            } 
            successCallBack?(data as! T)
        }
    }
}

public typealias TYNetworkReachabilityManager = NetworkReachabilityManager
public func configNetworkReachabilityManager() -> TYNetworkReachabilityManager? {
    let manager = TYNetworkReachabilityManager(host: "www.apple.com")
    manager?.listener = { status in
        if status == .notReachable || status == .unknown {
            //TyAlertHUD.showErrorMessage(text: "网络连接错误,请检查您的网络情况")
        } else {
            // 4G
            // WIFI
        }
    }
    return manager
}





















