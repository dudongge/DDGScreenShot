//
//  ViewController.swift
//  DDGScreenshot
//
//  Created by dudongge on 2018/3/19.
//  Copyright © 2018年 dudongge. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
   
    var tableView: UITableView!
    var dataSource = ["view截屏",
                      "scollView 截屏(长图)",
                      "web 截屏(长图)",
                      "wkWebView 截图（生成长图）",
                      "多图片图片合成（在图片上加logo)",
                      "给截图打上标签，文本，裁剪，圆角",
                      "截取图片的任意部分","图片擦除😜",
                      "图片滤镜--怀旧，黑白，岁月，烙黄，冲印,...",
                      "图片滤镜(高级)--饱和度，高斯模糊，老电影"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "截屏示例"
        self.view.backgroundColor = UIColor.white
        let height = self.view.frame.size.height
        let width = self.view.frame.size.width
        tableView = UITableView()
        tableView.frame = CGRect(x: 20, y: 80, width: width - 40, height: height - 200)
        tableView?.register(
            UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
}
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let viewShot = DDGViewShot()
            viewShot.title = dataSource[indexPath.row]
            self.navigationController?.pushViewController(viewShot, animated: true)
        } else if indexPath.row == 1 {
            let scollsViewShot = DDGScollViewShot()
            scollsViewShot.title = dataSource[indexPath.row]
            self.navigationController?.pushViewController(scollsViewShot, animated: true)
        } else if indexPath.row == 2 {
            let weblViewShot = DDGWeblViewShot()
            weblViewShot.title = dataSource[indexPath.row]
            self.navigationController?.pushViewController(weblViewShot, animated: true)
        } else if indexPath.row == 3 {
            let wKWebViewShot = DDGWKWebViewShot()
            wKWebViewShot.title = dataSource[indexPath.row]
            self.navigationController?.pushViewController(wKWebViewShot, animated: true)
        } else if indexPath.row == 4 {
            let imageCompose = DDGImageCompose()
            imageCompose.title = dataSource[indexPath.row]
            self.navigationController?.pushViewController(imageCompose, animated: true)
        } else if indexPath.row == 5 {
            let imageMark = DDGImageMark()
            imageMark.title = dataSource[indexPath.row]
            self.navigationController?.pushViewController(imageMark, animated: true)
        } else if indexPath.row == 6 {
            let imageShot = DDGShotImageView()
            imageShot.title = dataSource[indexPath.row]
            self.navigationController?.pushViewController(imageShot, animated: true)
        }else if indexPath.row == 7 {
            let clearImage = DDGClearImageView()
            clearImage.title = dataSource[indexPath.row]
            self.navigationController?.pushViewController(clearImage, animated: true)
        } else if indexPath.row == 8 {
            let imageFilter = DDGImageFilter()
            imageFilter.title = dataSource[indexPath.row]
            self.navigationController?.pushViewController(imageFilter, animated: true)
        } else if indexPath.row == 9 {
            let seniorImageFilter = DDGSeniorImageFilter()
            seniorImageFilter.title = dataSource[indexPath.row]
            self.navigationController?.pushViewController(seniorImageFilter, animated: true)
        }
    }
}

