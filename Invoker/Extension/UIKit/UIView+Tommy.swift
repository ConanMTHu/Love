//
//  UIView+Wecube.swift
//  Wecube
//
//  Created by Tommy on 16/9/26.
//  Copyright © 2016年 Tommy. All rights reserved.
//

import UIKit

// MARK: - 属性获取
extension UIView {
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: CGColor? {
        get {
            return layer.borderColor
        }
        set {
            layer.borderColor = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    var originX: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    
    var originY: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    
    var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center.x = newValue
        }
    }
    
    var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center.y = newValue
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
}

// MARK: - layer层属性设置
extension UIView {
    public func addCorner(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    public func addBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
    }
}

// MARK: - 动画
private let UIViewAnimationDuration: TimeInterval = 1
private let UIViewAnimationSpringDamping: CGFloat = 0.5
private let UIViewAnimationSpringVelocity: CGFloat = 0.5
extension UIView {
    public func spring(duration: TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: UIViewAnimationDuration,
            delay: 0,
            usingSpringWithDamping: UIViewAnimationSpringDamping,
            initialSpringVelocity: UIViewAnimationSpringVelocity,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: animations,
            completion: completion
        )
    }
}

extension UIView {
    public func toImage () -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

// MARK: - 点击事件闭包(默认添加tap手势)
fileprivate var blockActionDict: [String : ((UIView) -> ())] = [:]
extension UIView {
    public func click(_ action : @escaping ((UIView) -> Void)) {
        addBlock(action: action)
        whenTouch(numberOfTouche: 1, NumberOfTaps: 1)
    }
    
    private func key() -> String {
        return String(describing: NSValue(nonretainedObject: self))
    }
    
    private func whenTouch(numberOfTouche touchNumbers: Int,NumberOfTaps tapNumbers: Int) -> Void {
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTouchesRequired = touchNumbers
        tapGesture.numberOfTapsRequired = tapNumbers
        tapGesture.addTarget(self, action: #selector(UIView.tapActions(sender:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    private func addBlock(action newAction:@escaping (UIView)->()) {
        blockActionDict[key()] = newAction
    }
    
    private func excuteCurrentBlock(_ sender: UIView){
        guard let block = blockActionDict[key()] else {
            return;
        }
        block(sender)
    }
    
    func tapActions(sender: UIView) {
        excuteCurrentBlock(self)
    }
}
