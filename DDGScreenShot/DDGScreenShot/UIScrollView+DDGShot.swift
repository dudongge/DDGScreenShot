//
//  UIScrollView+DDGShot.swift
//  lottery
//
//  Created by dudongge on 2018/3/10.
//  Copyright © 2018年 CP. All rights reserved.
//

import Foundation
import WebKit

public extension UIScrollView {
    
    public func DDGContentScreenShot (_ completionHandler: @escaping (_ screenShotImage: UIImage?) -> Void) {
        
        self.isShoting = true
        
        // Put a fake Cover of View
        let snapShotView = self.snapshotView(afterScreenUpdates: false)
        snapShotView?.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: (snapShotView?.frame.size.width)!, height: (snapShotView?.frame.size.height)!)
        self.superview?.addSubview(snapShotView!)
        
        // Backup all properties of scrollview if needed
        let bakFrame     = self.frame
        let bakOffset    = self.contentOffset
        let bakSuperView = self.superview
        let bakIndex     = self.superview?.subviews.index(of: self)
        
        // Scroll To Bottom show all cached view
        if self.frame.size.height < self.contentSize.height {
            self.contentOffset = CGPoint(x: 0, y: self.contentSize.height - self.frame.size.height)
        }
        
        self.DDGRenderImageView({ [weak self] (screenShotImage) -> Void in
            // Recover View
            
            let strongSelf = self!
            
            strongSelf.removeFromSuperview()
            strongSelf.frame = bakFrame
            strongSelf.contentOffset = bakOffset
            bakSuperView?.insertSubview(strongSelf, at: bakIndex!)
            
            snapShotView?.removeFromSuperview()
            
            strongSelf.isShoting = false
            
            completionHandler(screenShotImage)
        })
        
    }
    
    fileprivate func DDGRenderImageView(_ completionHandler: @escaping (_ screenShotImage: UIImage?) -> Void) {
        // Rebuild scrollView superView and their hold relationship
        let ddgTempRenderView = UIView(frame: CGRect(x: 0, y: 0, width: self.contentSize.width, height: self.contentSize.height))
        self.removeFromSuperview()
        ddgTempRenderView.addSubview(self)
        
        self.contentOffset = CGPoint.zero
        self.frame         = ddgTempRenderView.bounds
        
        // Sometimes ScrollView will Capture nothing without defer;
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) { () -> Void in
            let bounds = self.bounds
            UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
            
            if (self.DDGContainsWKWebView()) {
                self.drawHierarchy(in: bounds, afterScreenUpdates: true)
            }else{
                self.layer.render(in: UIGraphicsGetCurrentContext()!)
            }
            let screenShotImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            completionHandler(screenShotImage)
        }
    }
    
    
    // Simulate People Action, all the `fixed` element will be repeate
    // DDGContentScrollScreenShot will capture all content without simulate people action, more perfect.
    public func DDGContentScrollScreenShot (_ completionHandler: @escaping (_ screenShotImage: UIImage?) -> Void) {
        
        self.isShoting = true
        
        // Put a fake Cover of View
        let snapShotView = self.snapshotView(afterScreenUpdates: true)
        snapShotView?.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: (snapShotView?.frame.size.width)!, height: (snapShotView?.frame.size.height)!)
        self.superview?.addSubview(snapShotView!)
        
        // Backup
        let bakOffset    = self.contentOffset
        
        // Divide
        let page  = floorf(Float(self.contentSize.height / self.bounds.height))
        
        UIGraphicsBeginImageContextWithOptions(self.contentSize, false, UIScreen.main.scale)
        
        self.DDGContentScrollPageDraw(0, maxIndex: Int(page), drawCallback: { [weak self] () -> Void in
            let strongSelf = self
            
            let screenShotImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            // Recover
            strongSelf?.setContentOffset(bakOffset, animated: false)
            snapShotView?.removeFromSuperview()
            
            strongSelf?.isShoting = false
            
            completionHandler(screenShotImage)
        })
        
    }
    
    fileprivate func DDGContentScrollPageDraw (_ index: Int, maxIndex: Int, drawCallback: @escaping () -> Void) {
        
        self.setContentOffset(CGPoint(x: 0, y: CGFloat(index) * self.frame.size.height), animated: false)
        let splitFrame = CGRect(x: 0, y: CGFloat(index) * self.frame.size.height, width: bounds.size.width, height: bounds.size.height)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) { () -> Void in
            self.drawHierarchy(in: splitFrame, afterScreenUpdates: true)
            
            if index < maxIndex {
                self.DDGContentScrollPageDraw(index + 1, maxIndex: maxIndex, drawCallback: drawCallback)
            }else{
                drawCallback()
            }
        }
    }
}

public extension UIWebView {
    
    public func DDGContentscreenShot (_ completionHandler: @escaping (_ screenShotImage: UIImage?) -> Void) {
        self.scrollView.DDGContentScreenShot(completionHandler)
    }
    
    public func DDGContentScrollScreenShot (_ completionHandler: @escaping (_ screenShotImage: UIImage?) -> Void) {
        self.scrollView.DDGContentScrollScreenShot(completionHandler)
    }
    
}

