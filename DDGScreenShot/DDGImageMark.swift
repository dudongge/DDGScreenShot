//
//  DDGImageMark.swift
//  DDGScreenshot
//
//  Created by dudongge on 2018/3/19.
//  Copyright © 2018年 dudongge. All rights reserved.
//

import UIKit

class DDGImageMark: UIViewController {
    var testImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
//        let image = UIImage(named:"1")?.drawTextInImage(text:"东阁堂主，给你一个star",
//                                                        textColor: UIColor.blue,
//                                                        textFont: 40,
//                                                        textBgColor: UIColor.green,
//                                                        textX: 20,
//                                                        textY: 100)
//        testImageView = UIImageView()
//        testImageView.image = image
//        testImageView.frame = CGRect(x: 10, y: 100, width: width - 20 , height: height - 200)
//        self.view.addSubview(testImageView)
        
        let imageView = UIImageView()
        self.view.addSubview(imageView)
        imageView.frame = CGRect(x: 50, y: 150, width: 100, height: 100)
        //imageView.image = DDGManage.share.tailoringImage("logo")
        let logo = UIImage(named: "logo")
        DDGManage.share.async_tailoringImage(logo!, completed: { (image)  in
            imageView.image = image!
        })
        
        let imageView2 = UIImageView()
        self.view.addSubview(imageView2)
        imageView2.frame = CGRect(x: 50, y: 250, width: 200, height: 200)
        let logoImage = UIImage(named: "logo")
        //imageView2.image = DDGManage.share.tailoringImage("logo", withRadius: 40.0)
        DDGManage.share.async_tailoringImage(logoImage!, withRadius: 50) { (image) in
            imageView2.image = image!
        }
        
        let imageView3 = UIImageView()
        self.view.addSubview(imageView3)
        imageView3.frame = CGRect(x: 50, y: 450, width: 100, height: 100)
        //imageView2.image = DDGManage.share.tailoringImage("logo", withRadius: 40.0)
        //imageView3.image = DDGManage.share.tailoringImage(UIImage(named: "logo")!, borderWidth: 4.0, borderColor: UIColor.red)
        DDGManage.share.async_tailoringImageLayer(UIImage(named: "logo")!,
                                                  borderWidth: 10.0,
                                                  borderColor: UIColor.red) { (image) in
              imageView3.image = image!
                                                    
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
