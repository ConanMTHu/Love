//
//  TyPlaceholderView.swift
//  Wecube
//
//  Created by Tommy on 2016/12/8.
//  Copyright © 2016年 Tommy. All rights reserved.
//

/**
 *
 *   针对于 网络异常 与 数据列表为空
 *
 */

import UIKit

class TyPlaceholderView: UIView {
    lazy var placeholderImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
