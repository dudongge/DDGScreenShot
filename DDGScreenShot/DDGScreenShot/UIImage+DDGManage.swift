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
    
    public func tailoringImage(_ image: UIImage) -> UIImage? {
        //开启上下文
        UIGraphicsBeginImageContext((image.size))
        //设置一个圆形的裁剪区域
        let path = UIBezierPath(ovalIn: CGRect(x: 0,
                                             y: 0,
                                             width: (image.size.width),
                                             height: (image.size.height)))
        
        //把路径设置为裁剪区域(超出裁剪区域以外的内容会被自动裁剪掉)
        path.addClip()
        //把图片绘制到上下文当中
        image.draw(at: CGPoint.zero)
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
    public  func async_tailoringImage(_ image: UIImage,completed:@escaping (UIImage?) -> ()) {

        DispatchQueue.global().async{
            let newImage = self.tailoringImage(image)
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
    public func tailoringImage(_ image: UIImage,withRadius radius: CGFloat) -> UIImage? {
        
        //开启上下文
        UIGraphicsBeginImageContext((image.size))
        //设置一个圆形的裁剪区域
        let path = UIBezierPath(roundedRect: CGRect(x: 0,
                                                    y: 0,
                                                    width: (image.size.width),
                                                    height: (image.size.height)), cornerRadius: radius)
        //把路径设置为裁剪区域(超出裁剪区域以外的内容会被自动裁剪掉)
        path.addClip()
        //把图片绘制到上下文当中
        image.draw(at: CGPoint.zero)
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
    public func async_tailoringImage(_ image: UIImage,withRadius radius: CGFloat,completed:@escaping (UIImage?) -> ()) -> Void {
        DispatchQueue.global().async{
            let newImage = self.tailoringImage(image, withRadius: radius)
            DispatchQueue.main.async(execute: {
                completed(newImage)
            })
        }
    }
    /**
     ** 绘图方式将图片裁剪成圆角并添加边框
     - imageName --传头头像名称
     - borderWidth --边框大小
     - borderColor --边框颜色
     */
    public func tailoringImageLayer(_ image: UIImage,borderWidth width:CGFloat,borderColor color: UIColor ) -> UIImage? {
        //1.先开启一个图片上下文 ,尺寸大小在原始图片基础上宽高都加上两倍边框宽度.
        let imageSize = CGSize(width: image.size.width + width * 2 , height: image.size.height + width * 2)
        UIGraphicsBeginImageContext(imageSize)
        //2.填充一个圆形路径.这个圆形路径大小,和上下文尺寸大小一样.
        //把大圆画到上下文当中.
        let path = UIBezierPath(ovalIn: CGRect(x: 0,
                                               y: 0,
                                               width: imageSize.width,
                                               height: imageSize.height))
        //颜色设置
        color.set()
        //填充
        path.fill()
        //3.添加一个小圆,小圆,x,y从边框宽度位置开始添加,宽高和原始图片一样大小.把小圆设为裁剪区域.
        let clipPath = UIBezierPath(ovalIn: CGRect(x: width, y: width, width: image.size.width, height: image.size.height))
        //把小圆设为裁剪区域.
        clipPath.addClip()
        //4.把图片给绘制上去.
        image.draw(at: CGPoint(x: width, y: width))
        //5.从上下文当中生成一张图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //6.关闭上下文
        UIGraphicsEndImageContext()
        return  newImage
    }
    /**
     ** 异步绘图方式将图片裁剪成圆角并添加边框
     - imageName --传头头像名称
     - borderWidth --边框大小
     - borderColor --边框颜色
     - parameter completed:    异步完成回调(主线程回调)
     */
    public func async_tailoringImageLayer(_ image: UIImage,borderWidth width:CGFloat,borderColor color: UIColor ,completed:@escaping (UIImage?) -> ()) -> Void {
        DispatchQueue.global().async{
            let newImage = self.tailoringImageLayer(image, borderWidth: width, borderColor: color)
            DispatchQueue.main.async(execute: {
                completed(newImage)
            })
        }
    }
    /**
     ** frame截图（截取图片的任意部分）
     - imageView --传图片
     - bgView --截图背景
     - parameter completed:    异步完成回调(主线程回调)
     */
    public func shotImage(image: UIImage?,byFrame frame: CGRect?) -> UIImage? {
        if image == nil {
            return nil
        }
        //开启一个位图上下文
        UIGraphicsBeginImageContextWithOptions((image?.size)!, false, 0.0)
        //用贝塞尔绘制
        let path = UIBezierPath(rect: frame!)
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
     ** 异步截取 frame截图（截取图片的任意部分）
     - imageView --传图片
     - bgView --截图背景
     - parameter completed:    异步完成回调(主线程回调)
     */
    public func async_shotImage(image: UIImage?,byFrame frame: CGRect?,completed:@escaping (UIImage?) -> ()) -> Void {
        DispatchQueue.global().async{
            let newImage = self.shotImage(image: image, byFrame: frame)
            DispatchQueue.main.async(execute: {
                completed(newImage)
            })
        }
    }
    
    /**
     ** 用手势截图（截取图片的任意部分）
     - imageView --传图片
     - bgView --截图背景
     - parameter completed:    异步完成回调(主线程回调)
     */
    public func shotImage(imageView: UIImageView?,bgView: UIView?) -> UIImage? {
        if imageView == nil {
            return nil
        }
        //开启一个位图上下文
        UIGraphicsBeginImageContextWithOptions((imageView?.bounds.size)!, false, 0.0)
        //用贝塞尔绘制
        let path = UIBezierPath(rect: (bgView?.frame)!)
        //开始截取
        path.addClip()
        //把ImageView的内容渲染上下文当中.
        let imgectx = UIGraphicsGetCurrentContext()
        imageView?.layer.render(in: imgectx!)
        //从上下文中得到图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        return newImage
    }
    /**
     ** 异步用手势截图（截取图片的任意部分）
     - imageView --传图片
     - bgView --截图背景
     - parameter completed:    异步完成回调(主线程回调)
     */
    public func async_shotImage(imageView: UIImageView?,bgView: UIView?,completed:@escaping (UIImage?) -> ()) -> Void {
        DispatchQueue.global().async{
            let newImage = self.shotImage(imageView: imageView, bgView: bgView)
            DispatchQueue.main.async(execute: {
                completed(newImage)
            })
        }
    }
    /**
     ** 用手势擦除图片
     - imageView --传图片
     - bgView --截图背景
     - parameter completed:    异步完成回调(主线程回调)
     */
    public func clearImage(imageView: UIImageView?, rect: CGRect) -> UIImage? {
        if imageView == nil {
            return nil
        }
        //开启一个位图上下文
        UIGraphicsBeginImageContextWithOptions((imageView?.bounds.size)!, false, 0.0)
        //把ImageView内容渲染到上下文当中
        let imageCtx = UIGraphicsGetCurrentContext()
        imageView?.layer.render(in: imageCtx!)
        //擦除上下文当中某一块区域
        imageCtx!.clear(rect)
        //得到新图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()

        return newImage
    }
    
    //MARK: 图像滤镜处理篇
    /**
     ** 图片滤镜处理篇
     - image --传图片
     - filter -- 传入滤镜
     */
    public func imageFilterHandel(image: UIImage, filterName: String) -> UIImage? {
        //输入图片
        let inputImage = CIImage(image: image)
        //设置filter健值
        let filter = CIFilter(name: filterName)
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        //得到滤镜中输出图像
        let outputImage =  filter?.outputImage!
        //设置上下文
        let context: CIContext = CIContext(options: nil)
        //通过上下文绘制获取
        let cgImage = context.createCGImage(outputImage!, from: (outputImage?.extent)!)
        //得到最新的图片
        let newImage = UIImage(cgImage: cgImage!)
        return newImage
    }
    /**
     ** 图片滤镜处理篇
     - image --传图片
     - filter -- 传入滤镜
     - parameter completed:    异步完成回调(主线程回调)
     */
    public func async_imageFilterHandel(image: UIImage, filterName: String,completed:@escaping (UIImage?) -> ()) -> Void {
        DispatchQueue.global().async{
            let newImage = self.imageFilterHandel(image: image, filterName: filterName)
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

