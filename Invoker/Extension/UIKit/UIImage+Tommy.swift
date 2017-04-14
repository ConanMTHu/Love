//
//  UIImage+Tommy.swift
//  Wecube
//
//  Created by Tommy on 2016/11/23.
//  Copyright © 2016年 Tommy. All rights reserved.
//

import UIKit

extension UIImage {
    public func with(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context?.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

public extension UIImage {
    public func compressed(quality: CGFloat = 0.5) -> UIImage? {
        guard let data = compressedData(quality: quality) else {
            return nil
        }
        return UIImage(data: data)
    }
    
    public func compressedData(quality: CGFloat = 0.5) -> Data? {
        return UIImageJPEGRepresentation(self, quality)
    }
    
    public func cropped(to rect: CGRect) -> UIImage {
        guard rect.size.height < self.size.height && rect.size.height < self.size.height else {
            return self
        }
        guard let cgImage: CGImage = self.cgImage?.cropping(to: rect) else {
            return self
        }
        return UIImage(cgImage: cgImage)
    }
    
    public func scaled(toHeight: CGFloat, with orientation: UIImageOrientation? = nil) -> UIImage? {
        let scale = toHeight / self.size.height
        let newWidth = self.size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: toHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: toHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    public func scaled(toWidth: CGFloat, with orientation: UIImageOrientation? = nil) -> UIImage? {
        let scale = toWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: toWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: toWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
