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
        let image = UIImage(named:"1")?.drawTextInImage(text:"东阁堂主，给你一个star",
                                                        textColor: UIColor.blue,
                                                        textFont: 40,
                                                        textBgColor: UIColor.green,
                                                        textX: 20,
                                                        textY: 100)
        testImageView = UIImageView()
        testImageView.image = image
        testImageView.frame = CGRect(x: 10, y: 100, width: width - 20 , height: height - 200)
        self.view.addSubview(testImageView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
