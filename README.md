## DDGScreenShot
DDGScreenShot , just one line of code, can handle the following functions, the part is still in the basic function, will continue to update, the latest version of the function is as follows.

DDGScreenShot截屏图片处理，只需一句代码，即可搞定如下功能，部分还处于基础功能，会持续更新中，最新版本功能如下：


```
1. Complex screen capture （eg: view ScrollView webView wkwebView）
2. Multi-picture image composition (with logo on the picture)(with a child
thread method), etc.
3. Label the screenshot, text, cut, rounded corners.
4. Interception of any part of the image (interception, frame capture) "," image erasure😜
5. Photo filter - nostalgic, black and white, years, branding, stamping.
6. Image filter (advanced)- saturation, gaussian blur, old film, etc.
```

1. 复杂屏幕截屏（如view ScrollView webView wkwebView）
2. 多图片图片合成（在图片上加logo)(有子线程方法)等
3. 给截图打上标签，文本，裁剪，圆角
4. 截取图片的任意部分（手势截取，frame截取）","图片擦除😜
5. 图片滤镜--怀旧，黑白，岁月，烙黄，冲印,...
6. 图片滤镜(高级)--饱和度，高斯模糊，老电影等
### It is interesting that friends can join the group and discuss some problems related to image processing.
### 有兴趣是小伙伴可以加入群，探讨一些图片处理相关的问题：
扫一扫加入群聊😜😜😜😜
![image](https://raw.githubusercontent.com/dudongge/DDGScreenShot/master/gif/QQgroup.png)

#### There is no intrusive part of the original code.
#### 对原有代码没有侵入性  部分效果如下：

![image](https://raw.githubusercontent.com/dudongge/DDGScreenShot/master/gif/DDGImage0.gif)![image](https://raw.githubusercontent.com/dudongge/DDGScreenShot/master/gif/DDGImage1.gif)!

## How to use : 使用方法：
Direct drag method: the utility classDDGScreenShot .File drag (currently used in the latest swift4.0 language,4.1 is fine)
##
直接拖入方法：将工具类 DDGScreenShot
文件拖入即可（目前使用的是最新的swift4.0语言,4.1 也没问题）。
## view截屏：
```
view.DDGScreenShot { (image) in
get the image (拿到图片)
Various complex loading operation。（各种复杂装逼操作）
、、、、
}
```

## ScrollView截屏：

scrollView.DDGContentScrollScreenShot { (image) in
get the image (拿到图片)
Various complex loading operation。（各种复杂装逼操作）

}


## webView截屏：
webView.DDGContentscreenShot { (image) in
get the image (拿到图片)
Various complex loading operation。（各种复杂装逼操作）
}
## wkwebView截屏： 方法和webView 一样，内部做了校验
webView.DDGContentscreenShot { (image) in
get the image (拿到图片)
Various complex loading operation。（各种复杂装逼操作）
}
## image 加 logo
let image = image.composeImageWithLogo( logo: UIImage,
logoOrigin: CGPoint,
logoSize:CGSize) 
传入 logo图片，logo位置 logo 大小 就可以得到一张生成好的图片                         
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
## image 图片裁剪圆角
传入image 详见demo
DDGManage.share.async_tailoringImage(image!, completed: { (image)  in
拿到 image 
各种复杂装逼操作
})
传入image withRadius：要截取的圆角  详见demo
DDGManage.share.async_tailoringImage(image!, withRadius: 50) { (image) in
拿到 image 
各种复杂装逼操作
}
传入image withRadius：要截取的圆角 borderColor: 边框颜色 详见demo
DDGManage.share.async_tailoringImageLayer(image,
borderWidth: 10.0,
borderColor: UIColor.red) { (image) in
get the image (拿到图片)
Various complex loading operation。（各种复杂装逼操作） 

}
### 截取图片的任意部分 图片滤镜及高级用法
```
详见demo
```

## 使用pod
iOS 9.0+, Swift 4.0+(Compatiable)
使用pod 导入
```
pod 'DDGScreenShot', '~> 1.1.6'
```

## License

DDGScreenShot is available under the MIT license. See the LICENSE file for more info.
如果有问题欢迎提出，QQ：532835032 ，如果对您有帮助，希望您动动鼠标，不吝给个star.!


## instructions （备注）

感谢   leewaycn 将本库截图功能翻译成OC，大家多了一个选择，附上链接，希望可以帮到你：
https://github.com/leewaycn/LVScreenShot







