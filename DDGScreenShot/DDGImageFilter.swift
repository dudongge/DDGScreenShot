//
//  DDGImageFilter.swift
//  DDGScreenShot
//
//  Created by dudongge on 2018/5/1.
//  Copyright © 2018年 dudongge. All rights reserved.
//

import UIKit

class DDGImageFilter: UIViewController {
    var imageView: UIImageView!
    var originalImage: UIImage = UIImage(named: "image")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let btnWidth = (self.view.frame.size.width - 40 ) / 4
        self.imageView = UIImageView()
        self.imageView.frame = CGRect(x: 20, y: 70, width:width - 40, height: width)
        self.imageView.layer.shadowOpacity = 0.8
        self.imageView.layer.shadowColor = UIColor.black.cgColor
        self.imageView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.imageView.image = originalImage
        self.view.addSubview(imageView)
        
        let titleArr = ["怀旧","黑白","色调","岁月","单色","褪色","冲印","烙黄","原图"]
        for i  in 0 ..< titleArr.count {
            let changeBtn = UIButton()
            changeBtn.tag = 100 + i
            changeBtn.frame = CGRect(x: 20 + btnWidth * CGFloat(i % 4), y: width + 100 + 40 * CGFloat(i / 4), width: btnWidth  , height: 40 )
            changeBtn.setTitle(titleArr[i], for: .normal)
            if i == 8 {
                changeBtn.backgroundColor = UIColor.yellow
            }
            changeBtn.setTitleColor(UIColor.black, for: .normal)
            changeBtn.addTarget(self, action: #selector(DDGImageFilter.addImageFilter(changeBtn:)), for: .touchUpInside)
            self.view.addSubview(changeBtn)
        }
    }
    @objc func addImageFilter(changeBtn: UIButton) {
        resetBtn()
        switch changeBtn.tag - 100 {
        case 0:
            let newImage = DDGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectInstant")
            self.imageView.image = newImage
            changeBtn.backgroundColor = UIColor.yellow
        case 1:
            //let newImage = DDGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectNoir")
            weak var ws = self
            DDGManage.share.async_imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectNoir") { (newImage) in
                ws!.imageView.image = newImage
            }
            changeBtn.backgroundColor = UIColor.yellow
        case 2:
            let newImage = DDGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectTonal")
            self.imageView.image = newImage
            changeBtn.backgroundColor = UIColor.yellow
        case 3:
            let newImage = DDGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectTransfer")
            self.imageView.image = newImage
            changeBtn.backgroundColor = UIColor.yellow
        case 4:
            let newImage = DDGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectMono")
            self.imageView.image = newImage
            changeBtn.backgroundColor = UIColor.yellow
        case 5:
            let newImage = DDGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectFade")
            self.imageView.image = newImage
            changeBtn.backgroundColor = UIColor.yellow
        case 6:
            let newImage = DDGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectProcess")
            self.imageView.image = newImage
            changeBtn.backgroundColor = UIColor.yellow
        case 7:
            let newImage = DDGManage.share.imageFilterHandel(image: originalImage, filterName: "CIPhotoEffectChrome")
            self.imageView.image = newImage
            changeBtn.backgroundColor = UIColor.yellow
        case 8:
            self.imageView.image = originalImage
            changeBtn.backgroundColor = UIColor.yellow
        default:
            break
        }
    }
    
    func resetBtn() {
        for views in self.view.subviews {
            if views.tag - 100 <= 10 {
                views.backgroundColor = UIColor.white
            }
        }
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
