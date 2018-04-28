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
    public func composeImageWithLogo( bgImage: UIImage,
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
    
    /*
     ** 用绘图方式将图片进行圆角裁剪
     ** imageName--传头头像名称
     */
    
    public func tailoringImage(_ imageName: String) -> UIImage? {
        let image = UIImage(named: imageName)
        if image == nil {
            return UIImage()
        }
        //开启上下文
        UIGraphicsBeginImageContext((image?.size)!)
        //设置一个圆形的裁剪区域
        let path = UIBezierPath(ovalIn: CGRect(x: 0,
                                             y: 0,
                                             width: (image?.size.width)!,
                                             height: (image?.size.height)!))
        
        //把路径设置为裁剪区域(超出裁剪区域以外的内容会被自动裁剪掉)
        path.addClip()
        //把图片绘制到上下文当中
        image?.draw(at: CGPoint.zero)
        //从上下文当中生成一张图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        return newImage
    }
    /**
     ** 用异步绘图方式将图片进行圆角裁剪
     - imageName--传头头像名称
     - parameter completed:    异步完成回调(主线程回调)
     */
    public  func async_tailoringImage(_ imageName: String,completed:@escaping (UIImage?) -> ()) {

        DispatchQueue.global().async{
            let newImage = self.tailoringImage(imageName)
            DispatchQueue.main.async(execute: {
                completed(newImage)
            })
        }
    }
    /**
     ** 用异步绘图方式将图片进行任意圆角裁剪
     - imageName --传头头像名称
     - cornerRadius --传头头像名称
     */
    public func tailoringImage(_ imageName: String,withRadius radius: CGFloat) -> UIImage? {
        let image = UIImage(named: imageName)
        if image == nil {
            return UIImage()
        }
        //开启上下文
        UIGraphicsBeginImageContext((image?.size)!)
        //设置一个圆形的裁剪区域
        let path = UIBezierPath(roundedRect: CGRect(x: 0,
                                                    y: 0,
                                                    width: (image?.size.width)!,
                                                    height: (image?.size.height)!), cornerRadius: radius)
        
        //把路径设置为裁剪区域(超出裁剪区域以外的内容会被自动裁剪掉)
        path.addClip()
        //把图片绘制到上下文当中
        image?.draw(at: CGPoint.zero)
        //从上下文当中生成一张图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        return newImage
    }
    /**
     ** 用异步绘图方式将图片进行任意圆角裁剪
     - imageName --传头头像名称
     - cornerRadius --要设置圆角的大小
     - parameter completed:    异步完成回调(主线程回调)
     */
    public func async_tailoringImage(_ imageName: String,withRadius radius: CGFloat,completed:@escaping (UIImage?) -> ()) -> Void {
        DispatchQueue.global().async{
            let newImage = self.tailoringImage(imageName, withRadius: radius)
            DispatchQueue.main.async(execute: {
                completed(newImage)
            })
        }
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

