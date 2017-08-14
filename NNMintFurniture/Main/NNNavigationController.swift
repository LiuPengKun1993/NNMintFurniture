//
//  NNNavigationController.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/7.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit
import SVProgressHUD

class NNNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = UIColor.init(red: 0, green: 198 / 255.0, blue: 176 / 255.0, alpha: 1);
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 17)]
    }

    /// 重写方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "beauty_icon_back"), style: .plain, target: self, action: #selector(navigationBackClick))
        }
        super.pushViewController(viewController, animated: true)
    }
    
    /// 返回按钮
    func navigationBackClick() {
        /// 隐藏提示框
        if SVProgressHUD.isVisible() {
            SVProgressHUD.dismiss()
        }
        /// 隐藏指示器
        if UIApplication.shared.isNetworkActivityIndicatorVisible {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        /// pop 出页面
        popViewController(animated: true)
    }
}
