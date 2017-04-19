//
//  TyLoadingView.swift
//  Wecube
//
//  Created by Tommy on 2016/12/8.
//  Copyright © 2016年 Tommy. All rights reserved.
//

import UIKit

class TyLoadingView: UIView {
    lazy var backgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: App.screenWidth, height: App.screenHeight))
        view.backgroundColor = .black
        view.alpha = 0.15
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addSubview(backgroundView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpAnimateView(message msg: String) {
        let animateView =  TyAnimatedMaskView(frame: CGRect(x: App.lastWindow.centerX, y: App.lastWindow.centerY - 100, width: 180, height: 100))
        let attrs: [String: Any] = [NSFontAttributeName: UIFont(name: "PingFangSC-Semibold", size: 38.0)!]
        animateView.messageLabel.attributedText = NSMutableAttributedString(string: msg, attributes: attrs)
        self.addSubview(animateView)
    }
    
    static func show(message msg: String = "吾乃闪耀\n  的知识灯塔") {
        let loadingView = TyLoadingView(frame: CGRect(x: 0, y: 0, width: App.screenWidth, height: App.screenHeight))
        loadingView.tag = 9999
        loadingView.setUpAnimateView(message: msg)
        App.topView.addSubview(loadingView)
    }
    
    static func disMiss() {
        guard let loadingView = App.topView.viewWithTag(9999) else {
            return
        }
        loadingView.removeFromSuperview()
    }
}

class TyAnimatedMaskView: UIView { 
    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        // 颜色渐变方向
        layer.startPoint = CGPoint(x: 0.0, y: 0.5)
        layer.endPoint = CGPoint(x: 1.0, y: 0.5)
        // 颜色组合
        layer.colors = [UIColor.white.cgColor, UIColor(hexString: "#e8e4cc")!.cgColor, UIColor.white.cgColor]
        // 不是表示颜色值所在位置,它表示的是颜色在Layer坐标系相对位置处要开始进行渐变颜色了.
        layer.locations = [0.25, 0.5, 0.75]
        return layer
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.transform = CGAffineTransform(rotationAngle: CGFloat(-4.0).degreesToRadians())
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
        messageLabel.frame = CGRect(x: 0, y: 0, width: App.screenWidth, height: self.height)
        layer.addSublayer(gradientLayer)
        gradientLayer.mask = messageLabel.layer
        
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [0.0, 0.0, 0.25]
        gradientAnimation.toValue = [0.75, 1.0, 1.0]
        gradientAnimation.duration = 2.0
        gradientAnimation.repeatCount = Float.infinity // 无穷大
        
        gradientLayer.add(gradientAnimation, forKey: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = CGRect( x: -bounds.size.width,
                                      y: bounds.origin.y,
                                      width: 3 * bounds.size.width, height: bounds.size.height)
    }
}
