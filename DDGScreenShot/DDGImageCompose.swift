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
        
        var image = UIImage(named:"1")
        image = image?.composeImageWithLogo(logo: UIImage(named: "logo")!,
                                            logoOrigin:CGPoint(x: 100, y: 50),
                                            logoSize: CGSize(width: 140, height: 120))
        testImageView = UIImageView()
        testImageView.image = image
        testImageView.frame = CGRect(x: 10, y: 100, width: width - 20 , height: height - 200)
        self.view.addSubview(testImageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
