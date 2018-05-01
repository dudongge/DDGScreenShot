//
//  DDGShotImageViewController.swift
//  DDGScreenShot
//
//  Created by dudongge on 2018/4/29.
//  Copyright © 2018年 dudongge. All rights reserved.
//

import UIKit

class DDGShotImageView: UIViewController {
    var imageView: UIImageView?
    var bgView: UIView?
    var startPoint: CGPoint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        imageView = UIImageView()
        self.view.addSubview(imageView!)
        imageView?.image = UIImage(named: "0")
        imageView?.isUserInteractionEnabled = true
        imageView?.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
       
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panTouch(startPan:)))
        imageView?.addGestureRecognizer(pan)
    }
    func setBgView() {
        if bgView == nil {
            bgView = UIView()
        }
        self.view.addSubview(bgView!)
        bgView?.backgroundColor = UIColor.black
        bgView?.alpha = 0.7
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func panTouch(startPan: UIPanGestureRecognizer) {
        let shotPan = startPan.location(in: imageView)
        //获取起始点
        self.setBgView()
        if startPan.state == .began {
            //获取当前点
            self.startPoint = shotPan
        } else if startPan.state == .changed {
            //获取当前点
            let X = startPoint.x
            let Y = startPoint.y
            let W = shotPan.x - startPoint.x
            let H = shotPan.y - startPoint.y
            let rect = CGRect(x: X, y: Y, width: W, height: H)
            bgView?.frame = rect
        } else if startPan.state == .ended {
            
           let newImage = DDGManage.share.shotImage(imageView: imageView, bgView: bgView)
            bgView?.removeFromSuperview()
            bgView = nil
        let imageView1 = UIImageView()
        self.view.addSubview(imageView1)
        imageView1.image = newImage
        imageView1.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
       }
    }
}
