//
//  DDGWKWebViewShot.swift
//  DDGScreenshot
//
//  Created by dudongge on 2018/3/19.
//  Copyright © 2018年 dudongge. All rights reserved.
//

import UIKit
import WebKit

class DDGWKWebViewShot: UIViewController ,WKUIDelegate,WKNavigationDelegate {
    var wkWebView: WKWebView!
    var storeScrollView: UIScrollView!
    var storeImage: UIImageView! //保存截取的图片
    var activity: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        wkWebView = WKWebView()
        wkWebView.frame = CGRect(x: 10, y: navHeight, width: width - 20 , height:height - navHeight - bottomMargint)
        self.view.addSubview(wkWebView)
        wkWebView.uiDelegate = self
        wkWebView.navigationDelegate = self
        wkWebView.backgroundColor = UIColor.purple
        wkWebView.load(URLRequest(url: URL(string: "https://www.jianshu.com/p/7c8cf9bef56f")!))
        
        let leftBtn = UIButton()
        leftBtn.backgroundColor = UIColor.yellow
        leftBtn.setTitle("截wkwebImage", for: .normal)
        leftBtn.setTitleColor(UIColor.blue, for: .normal)
        leftBtn.addTarget(self, action: #selector(DDGWKWebViewShot.screenShotWebView), for: .touchUpInside)
        leftBtn.frame =  CGRect(x: 20, y: height - bottomMargint, width:(width - 60) / 2, height: 40)
        self.view.addSubview(leftBtn)
        
        let rightBtn = UIButton()
        rightBtn.backgroundColor = UIColor.yellow
        rightBtn.setTitle("清除", for: .normal)
        rightBtn.setTitleColor(UIColor.blue, for: .normal)
        rightBtn.addTarget(self, action: #selector(DDGWKWebViewShot.clearShotScreen), for: .touchUpInside)
        rightBtn.frame = CGRect(x: (width - 60) / 2 + 40, y: height - bottomMargint, width: (width - 60) / 2, height: 40)
        self.view.addSubview(rightBtn)
        
        activity = UIActivityIndicatorView()
        activity.style = .whiteLarge
        activity.frame = CGRect(x:width / 2.0 - 15, y: 70, width: 30, height: 30)
        activity.backgroundColor = UIColor.black
        activity.hidesWhenStopped = true
        self.view.addSubview(activity)
        
    }
    @objc func screenShotWebView() {
        weak var ws = self
        activity.isHidden = false
        activity.startAnimating()
        wkWebView.DDGContentScreenShot { (image) in
            ws!.showScreenShot(image)
            ws!.activity.isHidden = true
            ws!.activity.stopAnimating()
        }
    }
    func showScreenShot(_ image: UIImage?) {
        
        storeScrollView = UIScrollView()
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
    
    @objc func clearShotScreen() {
        if storeScrollView != nil {
            storeScrollView.removeFromSuperview()
            storeScrollView = nil
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activity.isHidden = false
        activity.startAnimating()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.isHidden = true
        activity.stopAnimating()
    }

}
