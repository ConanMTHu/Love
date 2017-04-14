//
//  TyAlertHUD.swift
//  Wecube
//
//  Created by Tommy on 2016/12/8.
//  Copyright © 2016年 Tommy. All rights reserved.
//

import Foundation
import UIKit

public typealias AlertBlock = (UIAlertAction) -> Void

public class TyAlertHUD {
//    public static func showSuccessMessage(text: String) {
//        APESuperHUD.showOrUpdateHUD(icon: .checkMark, message: text, duration: 1.0, presentingView: App.lastWindow, completion: nil)
//    }
//    
//    public static func showErrorMessage(text: String) {
//        APESuperHUD.showOrUpdateHUD(icon: .info, message: text, duration: 1.0, presentingView: App.lastWindow, completion: nil)
//    }
    
    public static func showSystemAlertView(title: String?, message: String?, okTitle: String? = "确定", cancelTitle: String? = nil, okHandler: AlertBlock? = nil, cancenlHandler: AlertBlock? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let cancel = cancelTitle {
            let cancelAction = UIAlertAction(title: cancel, style: .cancel, handler: cancenlHandler)
            alertController.addAction(cancelAction)
        }
        
        if let ok = okTitle {
            let okAction = UIAlertAction(title: ok, style: .default, handler: okHandler)
            alertController.addAction(okAction)
        }
        
        App.topViewController()?.present(alertController, animated: true, completion: nil)
    }
    
//    public static func showLoadingView(message msg: String = "Loading...") {
//        APESuperHUD.showOrUpdateHUD(loadingIndicator: .standard, message: msg, presentingView: App.topView)
//    }
//    
//    public static func cancelLoadingView() {
//        APESuperHUD.removeHUD(animated: true, presentingView: App.topView, completion: nil)
//    }
}


