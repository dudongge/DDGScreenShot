//
//  UIView+DDGShot.swift
//  lottery
//
//  Created by dudongge on 2018/3/10.
//  Copyright © 2018年 CP. All rights reserved.
//

import UIKit
import WebKit

private var DDGViewScreenShotKey_IsShoting: String = "DDGViewScreenShot_AssoKey_isShoting"

public extension UIView {
    
    public func ddgSetFrame(_ frame: CGRect) {
        // Do nothing, use for swizzling
    }
    
    var isShoting:Bool! {
        get {
            let num = objc_getAssociatedObject(self, &DDGViewScreenShotKey_IsShoting)
            if num == nil {
                return false
            }
            
            if let numObj = num as? NSNumber {
                return numObj.boolValue
            }else {
                return false
            }
        }
        set(newValue) {
            let num = NSNumber(value: newValue as Bool)
            objc_setAssociatedObject(self, &DDGViewScreenShotKey_IsShoting, num, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // Ref: chromium source - snapshot_manager, fix wkwebview screenshot bug.
    
    public func DDGContainsWKWebView() -> Bool {
        if self.isKind(of: WKWebView.self) {
            return true
        }
        for subView in self.subviews {
            if (subView.DDGContainsWKWebView()) {
                return true
            }
        }
        return false
    }
    
    public func DDGScreenShot(_ completionHandler: (_ screenShotImage: UIImage?) -> Void) {
        
        self.isShoting = true
        let bounds = self.bounds
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        context?.translateBy(x: -self.frame.origin.x, y: -self.frame.origin.y);
        
        if (DDGContainsWKWebView()) {
            self.drawHierarchy(in: bounds, afterScreenUpdates: true)
        }else{
            self.layer.render(in: context!)
        }
        let screenShotImage = UIGraphicsGetImageFromCurrentImageContext()
        context?.restoreGState();
        UIGraphicsEndImageContext()
        
        self.isShoting = false
        completionHandler(screenShotImage)
    }
}

