//
//  DDGScollViewShot.swift
//  DDGScreenshot
//
//  Created by dudongge on 2018/3/19.
//  Copyright © 2018年 dudongge. All rights reserved.
//

import UIKit

class DDGScollViewShot: UIViewController {
    var testScrollView: UIScrollView!
    var storeScrollView: UIScrollView!
    var storeImage: UIImageView! //保存截取的图片
    var activity: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setUpUI()
    }
    
    func setUpUI() {
        testScrollView = UIScrollView()
        testScrollView.contentSize = CGSize(width: width, height: height * 3)
        testScrollView.frame = CGRect(x: 10, y: 100, width: width - 20, height: height - 200)
        testScrollView.backgroundColor = UIColor.red
        self.view.addSubview(testScrollView)
        
        let imageView0 = UIImageView()
        imageView0.image = UIImage(named:"0")
        imageView0.frame = CGRect(x: 10, y: 10, width: width - 40, height: height * 0.9)
        testScrollView.addSubview(imageView0)
        
        let imageView1 = UIImageView()
        imageView1.image = UIImage(named:"1")
        imageView1.frame = CGRect(x: 10, y: height, width: width - 40, height: height * 0.9)
        testScrollView.addSubview(imageView1)
        
        let imageView2 = UIImageView()
        imageView2.image = UIImage(named:"2")
        imageView2.frame = CGRect(x: 10, y: height * 2.0, width: width - 40, height: height * 0.9)
        testScrollView.addSubview(imageView2)
        
        let leftBtn = UIButton()
        leftBtn.backgroundColor = UIColor.yellow
        leftBtn.setTitle("截ScrollImage", for: .normal)
        leftBtn.setTitleColor(UIColor.blue, for: .normal)
        leftBtn.addTarget(self, action: #selector(DDGScollViewShot.screenShotScroll), for: .touchUpInside)
        leftBtn.frame = CGRect(x: 20, y: height - bottomMargint, width: (width - 60) / 2, height: 40)
        self.view.addSubview(leftBtn)
        
        let rightBtn = UIButton()
        rightBtn.backgroundColor = UIColor.yellow
        rightBtn.setTitle("清除", for: .normal)
        rightBtn.setTitleColor(UIColor.blue, for: .normal)
        rightBtn.addTarget(self, action: #selector(DDGScollViewShot.clearShotScreen), for: .touchUpInside)
        rightBtn.frame = CGRect(x: (width - 60) / 2 + 40, y: height - bottomMargint, width: (width - 60) / 2, height: 40)
        self.view.addSubview(rightBtn)
        
        activity = UIActivityIndicatorView()
        activity.style = .whiteLarge
        activity.frame = CGRect(x:width / 2.0 - 15, y: 70, width: 30, height: 30)
        activity.backgroundColor = UIColor.black
        activity.hidesWhenStopped = true
        self.view.addSubview(activity)
        
    }
    
    @objc func screenShotScroll() {
        weak var ws = self
        activity.isHidden = false
        activity.startAnimating()
        self.testScrollView.DDGContentScrollScreenShot { (image) in
            ws!.showScreenShot(image!)
            ws!.activity.isHidden = true
            ws!.activity.stopAnimating()
        }
    }
    @objc func clearShotScreen() {
        if storeScrollView != nil {
            storeScrollView.removeFromSuperview()
            storeScrollView = nil
        }
    }
    func showScreenShot(_ image: UIImage) {
        
        if storeScrollView == nil {
            storeScrollView = UIScrollView()
        }
        storeScrollView.contentSize = CGSize(width: width * 0.5, height: height * 1.5)
        storeScrollView.frame.size = CGSize(width: width * 0.5, height: height * 0.5)
        storeScrollView.center = self.view.center
        storeScrollView.backgroundColor = UIColor.white
        self.view.addSubview(storeScrollView)
        
        storeImage = UIImageView()
        storeImage.image = image
        self.storeScrollView.addSubview(storeImage)
        storeImage.frame = CGRect(x: 0, y: 0, width: width * 0.5, height: height * 1.5)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
