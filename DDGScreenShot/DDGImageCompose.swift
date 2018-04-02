//
//  DDGImageCompose.swift
//  DDGScreenshot
//
//  Created by dudongge on 2018/3/19.
//  Copyright © 2018年 dudongge. All rights reserved.
//

import UIKit

class DDGImageCompose: UIViewController {
    var testImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        
        testImageView = UIImageView()
        testImageView.image = UIImage(named: "1")
        testImageView.frame = CGRect(x: 10, y: 100, width: width - 20 , height: height - 200)
        self.view.addSubview(testImageView)
        
        let leftBtn = UIButton()
        leftBtn.backgroundColor = UIColor.yellow
        leftBtn.setTitle("加logo", for: .normal)
        leftBtn.setTitleColor(UIColor.blue, for: .normal)
        leftBtn.addTarget(self, action: #selector(DDGImageCompose.addLogo), for: .touchUpInside)
        leftBtn.frame = CGRect(x: 20, y: height - 45, width: 100, height: 40)
        self.view.addSubview(leftBtn)
        
        let rightBtn = UIButton()
        rightBtn.backgroundColor = UIColor.yellow
        rightBtn.setTitle("多图片合成", for: .normal)
        rightBtn.setTitleColor(UIColor.blue, for: .normal)
        rightBtn.addTarget(self, action: #selector(DDGImageCompose.composeImages), for: .touchUpInside)
        rightBtn.frame = CGRect(x: 190, y: height - 45, width: 100, height: 40)
        self.view.addSubview(rightBtn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @objc func addLogo() {
        var image = UIImage(named:"1")
        image = image?.composeImageWithLogo(logo: UIImage(named: "logo")!,
                                            logoOrigin:CGPoint(x: 100, y: 50),
                                            logoSize: CGSize(width: 240, height: 120))
        testImageView.image = image
    }
    @objc func composeImages() {
        let images:[UIImage?] = [UIImage(named: "0"),
                     UIImage(named: "1"),
                     UIImage(named: "2"),
                     UIImage(named: "logo")]
        let imageRect = [CGRect(x: 10, y: 10, width: 200, height: 100),
                         CGRect(x: 30, y: 150, width: 300, height: 100),
                         CGRect(x: 21, y: 280, width: 200, height: 100),
                         CGRect(x: 280, y: 280, width: 200, height: 100)]
        let image = DDGManage.share.composeImageWithLogo(bgImage: UIImage(named: "bgGreen")!, imageRect:imageRect, images:images as! [UIImage] )
        testImageView.image = image
    }
}
