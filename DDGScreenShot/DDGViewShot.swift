//
//  DDGViewShot.swift
//  DDGScreenshot
//
//  Created by dudongge on 2018/3/19.
//  Copyright © 2018年 dudongge. All rights reserved.
//

import UIKit
let height = UIScreen.main.bounds.size.height
let width = UIScreen.main.bounds.size.width
class DDGViewShot: UIViewController {
    
    var blueView: UIView!
    var leftBtn: UIButton!
    var logoImageView: UIImageView!
    var imageView: UIImageView!
    var storeImage: UIImageView! //保存截取的图片
    var activity: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        blueView = UIView()
        blueView.backgroundColor = UIColor.blue
        blueView.center = self.view.center
        blueView.frame.size = CGSize(width: 100, height: 100)
        self.view.addSubview(blueView)
        
        logoImageView = UIImageView(image: UIImage(named:"logo"))
        logoImageView.frame = CGRect(x: 50, y: 100, width: 100, height: 100)
        self.view.addSubview(logoImageView)
        
        storeImage = UIImageView()
        self.view.addSubview(storeImage)
        
        
        let leftBtn = UIButton()
        leftBtn.backgroundColor = UIColor.yellow
        leftBtn.setTitle("截整个屏", for: .normal)
        leftBtn.setTitleColor(UIColor.blue, for: .normal)
        leftBtn.addTarget(self, action: #selector(DDGViewShot.screenShotAll), for: .touchUpInside)
        leftBtn.frame = CGRect(x: 20, y: height - bottomMargint, width: (width - 60) / 2, height: 40)
        self.view.addSubview(leftBtn)
        
        let rightBtn = UIButton()
        rightBtn.backgroundColor = UIColor.yellow
        rightBtn.setTitle("清除", for: .normal)
        rightBtn.setTitleColor(UIColor.blue, for: .normal)
        rightBtn.addTarget(self, action: #selector(DDGViewShot.clearShotScreen), for: .touchUpInside)
        rightBtn.frame = CGRect(x: (width - 60) / 2 + 40, y: height - bottomMargint, width: (width - 60) / 2, height: 40)
        self.view.addSubview(rightBtn)
        
        activity = UIActivityIndicatorView()
        activity.style = .whiteLarge
        activity.frame = CGRect(x:width / 2.0 - 15, y: 70, width: 30, height: 30)
        activity.backgroundColor = UIColor.black
        activity.hidesWhenStopped = true
        self.view.addSubview(activity)
    }

    @objc func screenShotAll() {
        weak var ws = self
        self.view.DDGScreenShot { (image) in
            ws!.storeImage.image = image
            ws!.storeImage.frame.size = CGSize(width: (image?.size.width)! * 0.5, height: (image?.size.height)! * 0.5)
            ws!.storeImage.center = ws!.view.center
            ws!.view.backgroundColor = UIColor.yellow
        }
    }
    @objc func clearShotScreen() {
        self.storeImage.image = UIImage(named:"")
        self.view.backgroundColor = UIColor.white
    }

}
