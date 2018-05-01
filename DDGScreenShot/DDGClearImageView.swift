//
//  ClearImageView.swift
//  DDGScreenShot
//
//  Created by dudongge on 2018/4/30.
//  Copyright © 2018年 dudongge. All rights reserved.
//

import UIKit

class DDGClearImageView: UIViewController {
    //底部图片
    private lazy var bottomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image")
        imageView.frame = CGRect(x: 0, y: 100, width: width, height: width)
        self.view.addSubview(imageView)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    //要擦除的图片
    private lazy var clearImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.frame = CGRect(x: 0, y: 100, width: width, height: width)
        imageView.isUserInteractionEnabled = true
        self.view.addSubview(imageView)
        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.bottomImageView.isUserInteractionEnabled = false
        let pan = UIPanGestureRecognizer(target: self, action: #selector(DDGClearImageView.clearPan(pan:)))
        self.clearImageView.addGestureRecognizer(pan)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @objc func clearPan(pan: UIPanGestureRecognizer) {
        //获取当前手指的点
        let imageView = pan.view as! UIImageView
        let clearPan = pan.location(in: imageView)
        //擦除区域的大小
        let rect = CGRect(x: clearPan.x - 15, y: clearPan.y - 15, width: 30, height: 30)
        let newImage = DDGManage.share.clearImage(imageView: imageView, rect: rect)
        
        imageView.image = newImage
    }

}
