//
//  SeniorViewController.swift
//  CoreImage-learning
//
//  Created by dudg on 2017/3/3.
//  Copyright © 2017年 dudg. All rights reserved.
//

import UIKit

class DDGSeniorImageFilter: UIViewController {
    var imageView: UIImageView!
    var slider: UISlider!
    var originalImage: UIImage = UIImage(named: "image")!

     var context: CIContext = {
        return CIContext(options: nil)
    }()
    var filter: CIFilter!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setupSubviews()
    }
    
    func setupSubviews(){
        
        let screenWidth = self.view.frame.size.width
        let btnWidth = (self.view.frame.size.width - 40 ) / 4
        
        
        self.imageView = UIImageView()
        self.imageView.frame = CGRect(x: 20, y: 70, width:screenWidth - 40, height: screenWidth)
        self.imageView.layer.shadowOpacity = 0.8
        self.imageView.layer.shadowColor = UIColor.black.cgColor
        self.imageView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.imageView.image = originalImage
        self.view.addSubview(imageView)
        
        slider = UISlider()
        slider.frame = CGRect(x: 20, y: screenWidth + 80, width: screenWidth - 40, height: 20)
        slider.maximumValue = Float(Double.pi)
        slider.minimumValue = Float(-Double.pi)
        slider.value = 0
        slider.addTarget(self, action: #selector(DDGSeniorImageFilter.valueChanged), for: UIControlEvents.valueChanged)
        self.view.addSubview(slider)
        
        let inputImage = CIImage(image: originalImage)
        filter = CIFilter(name: "CIHueAdjust")
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        slider.sendActions(for: UIControlEvents.valueChanged)
        
        
        let titleArr = ["原图","高斯模糊","老电影"]
        for i  in 0 ..< titleArr.count  {
            let changeBtn = UIButton()
            changeBtn.tag = 1000 + i
            changeBtn.frame = CGRect(x: 20 + btnWidth * CGFloat(i % 4), y: screenWidth + 100 + 40 * CGFloat(i / 4), width: btnWidth  , height: 40 )
            changeBtn.setTitle(titleArr[i], for: .normal)
            if i == 0 {
                changeBtn.backgroundColor = UIColor.yellow
            }
            changeBtn.setTitleColor(UIColor.black, for: .normal)
            changeBtn.addTarget(self, action: #selector(DDGSeniorImageFilter.addImageFilter(changeBtn:)), for: .touchUpInside)
            self.view.addSubview(changeBtn)
            
        }
        showFiltersInConsole()
    }
    
    func showFiltersInConsole() {
        let filterNames = CIFilter.filterNames(inCategory: kCICategoryBuiltIn)
        print(filterNames.count)
        //可以看到所有的设置滤镜的属性
        print(filterNames)
        for filterName in filterNames {
            let filter = CIFilter(name: filterName)!
            let attributes = filter.attributes
            print(attributes)
        }
    }
    @objc func valueChanged() {
        print(slider.value)
        //鲜明度
        filter.setValue(slider.value, forKey: "inputAngle")
        let outputImage = filter.outputImage!
        let cgImage = context.createCGImage(outputImage, from: outputImage.extent)
        imageView.image = UIImage(cgImage: cgImage!)
        
    }
    
    @objc func addImageFilter(changeBtn: UIButton) {
        self.resetBtn()
        switch changeBtn.tag - 1000 {
         // ["原图","反色","老电影"]
        case 0:
            self.imageView.image = originalImage
            changeBtn.backgroundColor = UIColor.yellow
        case 1:
            self.gaussianBlurFilmEffect()
            changeBtn.backgroundColor = UIColor.yellow
        case 2:
            self.oldFilmEffect()
            changeBtn.backgroundColor = UIColor.yellow
        default:
            break
        }
    }
    func gaussianBlurFilmEffect() {
        filter = CIFilter(name: "CIGaussianBlur")
        filter.setValue(10.0, forKey: "inputRadius")
        let inputImage = CIImage(image: originalImage)
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        let outputImage =  filter.outputImage!
        let cgImage = context.createCGImage(outputImage, from: outputImage.extent)
        self.imageView.image = UIImage(cgImage: cgImage!)

    }
    func oldFilmEffect(){
        let inputImage = CIImage(image: originalImage)!
        // 1.创建CISepiaTone滤镜（棕绿色）
        let sepiaToneFilter = CIFilter(name: "CISepiaTone")!
        sepiaToneFilter.setValue(inputImage, forKey: kCIInputImageKey)
        //参数是强度
        sepiaToneFilter.setValue(1, forKey: kCIInputIntensityKey)
//        let outputImage = sepiaToneFilter.outputImage!
//        let cgImage = context.createCGImage(outputImage, from: outputImage.extent)
//        imageView.image = UIImage(cgImage: cgImage!)
        // 2.创建白班图滤镜
        let whiteSpecksFilter = CIFilter(name: "CIColorMatrix")!
        whiteSpecksFilter.setValue(CIFilter(name: "CIRandomGenerator")!.outputImage!.cropped(to: inputImage.extent), forKey: kCIInputImageKey)
        whiteSpecksFilter.setValue(CIVector(x: 0, y: 1, z: 0, w: 0), forKey: "inputRVector")
        whiteSpecksFilter.setValue(CIVector(x: 0, y: 1, z: 0, w: 0), forKey: "inputGVector")
        whiteSpecksFilter.setValue(CIVector(x: 0, y: 1, z: 0, w: 0), forKey: "inputBVector")
        whiteSpecksFilter.setValue(CIVector(x: 0, y: 0, z: 0, w: 0), forKey: "inputBiasVector")
//        let outputImage = whiteSpecksFilter.outputImage!
//        let cgImage = context.createCGImage(outputImage, from: outputImage.extent)
//        imageView.image = UIImage(cgImage: cgImage!)
        // 3.把CISepiaTone滤镜和白班图滤镜以源覆盖(source over)的方式先组合起来
        let sourceOverCompositingFilter = CIFilter(name: "CISourceOverCompositing")!
        sourceOverCompositingFilter.setValue(whiteSpecksFilter.outputImage, forKey: kCIInputBackgroundImageKey)
        sourceOverCompositingFilter.setValue(sepiaToneFilter.outputImage, forKey: kCIInputImageKey)
        // 4.用CIAffineTransform滤镜先对随机噪点图进行处理 应用坐标系
        let affineTransformFilter = CIFilter(name: "CIAffineTransform")!
        affineTransformFilter.setValue(CIFilter(name: "CIRandomGenerator")!.outputImage!.cropped(to: inputImage.extent), forKey: kCIInputImageKey)
        affineTransformFilter.setValue(NSValue(cgAffineTransform: CGAffineTransform(scaleX: 1.5, y: 25)), forKey: kCIInputTransformKey)
//        let outputImage = affineTransformFilter.outputImage!
//        let cgImage = context.createCGImage(outputImage, from: outputImage.extent)
//        imageView.image = UIImage(cgImage: cgImage!)
        // 5.创建蓝绿色磨砂图滤镜
        let darkScratchesFilter = CIFilter(name: "CIColorMatrix")!
        darkScratchesFilter.setValue(affineTransformFilter.outputImage, forKey: kCIInputImageKey)
        darkScratchesFilter.setValue(CIVector(x: 4, y: 0, z: 0, w: 0), forKey: "inputRVector")
        darkScratchesFilter.setValue(CIVector(x: 0, y: 1, z: 0, w: 0), forKey: "inputGVector")
        darkScratchesFilter.setValue(CIVector(x: 0, y: 0, z: 0, w: 0), forKey: "inputBVector")
       darkScratchesFilter.setValue(CIVector(x: 0, y: 0, z: 0, w: 0), forKey: "inputAVector")
        darkScratchesFilter.setValue(CIVector(x: 0, y: 1, z: 1, w: 1), forKey: "inputBiasVector")
        // 6.用CIMinimumComponent滤镜把蓝绿色磨砂图滤镜处理成黑色磨砂图滤镜
        let minimumComponentFilter = CIFilter(name: "CIMinimumComponent")!
        minimumComponentFilter.setValue(darkScratchesFilter.outputImage, forKey: kCIInputImageKey)
        // 7.最终组合在一起
        let multiplyCompositingFilter = CIFilter(name: "CIMultiplyCompositing")!
        multiplyCompositingFilter.setValue(minimumComponentFilter.outputImage, forKey: kCIInputBackgroundImageKey)
        multiplyCompositingFilter.setValue(sourceOverCompositingFilter.outputImage, forKey: kCIInputImageKey)
        // 8.最后输出
        let outputImage = multiplyCompositingFilter.outputImage!
        let cgImage = context.createCGImage(outputImage, from: outputImage.extent)
        imageView.image = UIImage(cgImage: cgImage!)
        
    }
    func resetBtn() {
        for views in self.view.subviews {
            if views.tag - 1000 <= 10 {
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
