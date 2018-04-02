//
//  UIImage+DDGManage.swift
//  DDGScreenshot
//
//  Created by dudongge on 2018/3/28.
//  Copyright © 2018年 dudongge. All rights reserved.
//

import UIKit
import ObjectiveC

class DDGManage: NSObject {
    static var share = DDGManage()
    func composeImageWithLogo( bgImage: UIImage,
                               imageRect: [CGRect],
                               images:[UIImage]) -> UIImage {
        //以bgImage的图大小为底图
        let imageRef = bgImage.cgImage
        let w: CGFloat = CGFloat((imageRef?.width)!)
        let h: CGFloat = CGFloat((imageRef?.height)!)
        //以1.png的图大小为画布创建上下文
        UIGraphicsBeginImageContext(CGSize(width: w, height: h))
        bgImage.draw(in: CGRect(x: 0, y: 0, width: w, height: h))
        //先把1.png 画到上下文中
        for i in 0..<images.count {
            images[i].draw(in: CGRect(x: imageRect[i].origin.x,
                                      y: imageRect[i].origin.y,
                                      width: imageRect[i].size.width,
                                      height:imageRect[i].size.height))
        }
        //再把小图放在上下文中
        let resultImg: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        //从当前上下文中获得最终图片
        UIGraphicsEndImageContext()
        return resultImg!
    }
}

extension UIImage {
    
//   public func drawTextInImage(text: String,
//                         textColor: UIColor,
//                         textFont: CGFloat,
//                         textBgColor: UIColor,
//                         textX: CGFloat,
//                         textY: CGFloat )->UIImage {
//        //开启图片上下文
//        UIGraphicsBeginImageContext(self.size)
//        //图形重绘
//        self.draw(in: CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height))
//        //水印文字属性
//        let att = [NSAttributedStringKey.foregroundColor: textColor,
//                   NSAttributedStringKey.font: UIFont.systemFont(ofSize: textFont),
//                   NSAttributedStringKey.backgroundColor: textBgColor]
//        //水印文字大小
//        let text = NSString(string: text)
//        let size =  text.size(withAttributes: att)
//        //绘制文字
//        text.draw(in: CGRect.init(x: textX, y: textY, width: size.width, height: size.height), withAttributes: att)
//        //从当前上下文获取图片
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        //关闭上下文
//        UIGraphicsEndImageContext()
//        return image!
//    }
    public func composeImageWithLogo( logo: UIImage,
                               logoOrigin: CGPoint,
                               logoSize:CGSize) -> UIImage {
        //以bgImage的图大小为底图
        let imageRef = self.cgImage
        let w: CGFloat = CGFloat((imageRef?.width)!)
        let h: CGFloat = CGFloat((imageRef?.height)!)
        //以1.png的图大小为画布创建上下文
        UIGraphicsBeginImageContext(CGSize(width: w, height: h))
        self.draw(in: CGRect(x: 0, y: 0, width: w, height: h))
        //先把1.png 画到上下文中
        logo.draw(in: CGRect(x: logoOrigin.x,
                             y: logoOrigin.y,
                             width: logoSize.width,
                             height:logoSize.height))
        //再把小图放在上下文中
        let resultImg: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        //从当前上下文中获得最终图片
        UIGraphicsEndImageContext()
        return resultImg!
    }
}

