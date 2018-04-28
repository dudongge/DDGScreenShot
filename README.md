## DDGScreenShot
DDGScreenShot截屏图片处理，只需一句代码，即可搞定复杂屏幕截屏（如view ScrollView webView wkwebView），图片处理（加logo 打标签）文本，子线程（裁剪，切圆角）等
对原有代码没有侵入性  部分效果如下

 ![image](https://raw.githubusercontent.com/dudongge/DDGScreenShot/master/gif/showView.gif) ![image](https://raw.githubusercontent.com/dudongge/DDGScreenShot/master/gif/showScrollView.gif) ![image](https://raw.githubusercontent.com/dudongge/DDGScreenShot/master/gif/showWebView.gif) ![image](https://raw.githubusercontent.com/dudongge/DDGScreenShot/master/gif/showImagesCombin.gif) ![image](https://raw.githubusercontent.com/dudongge/DDGScreenShot/master/gif/showImageLogo.gif)
## 使用方法：
直接拖入方法：将工具类 DDGScreenShot 文件拖入即可（目前使用的是最新的swift4.0语言）。
   ## view截屏：
    view.DDGScreenShot { (image) in
         拿到 image 
         各种复杂装逼操作
         、、、、
    }
   ## ScrollView截屏：
    scrollView.DDGContentScrollScreenShot { (image) in
         拿到 image 
         各种复杂装逼操作
         、、、、
    }
  ## webView截屏：
    webView.DDGContentscreenShot { (image) in
         拿到 image 
         各种复杂装逼操作
         、、、、
    }
  ## wkwebView截屏： 方法和webView 一样，内部做了校验
      webView.DDGContentscreenShot { (image) in
           拿到 image 
           各种复杂装逼操作
           、、、、
      }
  ## image 加 logo
     let image = image.composeImageWithLogo( logo: UIImage,
                               logoOrigin: CGPoint,
                               logoSize:CGSize) 
     传入 logo图片，logo位置 logo 大小 就可以得到一张生成好的图片                         
         、、、、
  ## image 加 标签，水印，文字
     let image = image.drawTextInImage(text: String,
                         textColor: UIColor,
                         textFont: CGFloat,
                         textBgColor: UIColor,
                         textX: CGFloat,
                         textY: CGFloat ) 
     传入 文字、文字颜色、字体大小、背景颜色，字体起始位置 就可以得到一张生成好的带标签的图片
         注，此方法在提交pod有问题，故将方法屏蔽，有需要的可以拷贝代码，到本地
## image 多图片拼接
     func composeImageWithLogo( bgImage: UIImage,
     imageRect: [CGRect],
     images:[UIImage]) -> UIImage {
     传入背景图片 ，各个图片的frame 图片数组，就可以得到自己想要的图片拼接效果了
## image 图片裁剪
    DDGManage.share.async_tailoringImage("logo", completed: { (image)  in
        拿到 image 
        各种复杂装逼操作
    })
    DDGManage.share.async_tailoringImage("logo", withRadius: 50) { (image) in
        拿到 image 
        各种复杂装逼操作
    }
## 使用pod
     iOS 9.0+, Swift 4.0+(Compatiable)
        使用pod 导入
        ```
        pod 'DDGScreenShot', '~> 1.1.3'
        ```

        
 ## License
        
        DDGScreenShot is available under the MIT license. See the LICENSE file for more info.
        如果有问题欢迎提出，QQ：532835032 ，如果对您有帮助，希望您动动鼠标，不吝给个star.


 
 
