//
//  NNTabBarController.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/7.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit

class NNTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /// tabBar 颜色
        tabBar.tintColor = UIColor.init(colorLiteralRed: 0.000, green: 0.757, blue: 0.682, alpha: 1)
        /// tabBar 背景图片
        tabBar.backgroundImage = UIImage(named: "pfb_tabbar_background")
        /// 添加自控制器
        addChildControllers()
    }
    
    /// 添加自控制器
    func addChildControllers() {
        addChildController(childController: NNHomePageController(), title: "薄荷家居", imageName: "pfb_tabbar_homepage")
        addChildController(childController: NNItemController(), title: "单品", imageName: "pfb_tabbar_order")
        addChildController(childController: NNClassificationController(), title: "分类", imageName: "pfb_tabbar_discover")
        addChildController(childController: NNMeController(), title: "我", imageName: "pfb_tabbar_mine")
    }
    
    /// 添加自控制器
    private func addChildController(childController:UIViewController, title:String, imageName:String) {
        childController.title = title
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")
        let navigationVC = NNNavigationController(rootViewController: childController)
        addChildViewController(navigationVC)
    }
}
