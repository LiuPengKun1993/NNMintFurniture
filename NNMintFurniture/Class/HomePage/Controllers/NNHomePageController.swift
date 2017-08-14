//
//  NNHomePageController.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/7.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit

class NNHomePageController: NNBaseViewController, UIScrollViewDelegate {
    
    weak var contentView = UIScrollView()
    /// 当前选中的按钮
    weak var selectedButton = UIButton()
    let titlesArray = ["精选","卧室","书房","厨房","客厅","卫浴"]

    override func viewDidLoad() {
        super.viewDidLoad()
        /// 添加控制器
        addChildVC()
        /// 导航栏
        setupNav()
        /// 顶部标签栏
        setupTitlesView()
        /// 主要内容视图
        setupContentView()
    }
    
    /// 添加控制器
    func addChildVC() {
        for _ in 0..<titlesArray.count {
            let vc = NNTestViewController()
            addChildViewController(vc)
        }
    }
    
    /// 导航栏
    func setupNav() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:UIImage(named: "icon_homepage_searchbar_left"), style: .plain, target: self, action: #selector(rightBarButtonClick))
    }
    
    /// 顶部标签栏
    func setupTitlesView() {
        view.addSubview(bgView)
        bgView.addSubview(titlesView)
        bgView.addSubview(arrowButton)
        
        //内部子标签
        let width = titlesView.frame.size.width / CGFloat(titlesArray.count)
        let height = titlesView.frame.size.height
        
        for index in 0..<titlesArray.count {
            let button = UIButton()
            button.frame.size.height = height
            button.frame.size.width = width
            button.frame.origin.x = CGFloat(index) * width
            button.tag = index
            button.titleLabel!.font = UIFont.systemFont(ofSize: 15)
            button.setTitle(titlesArray[index], for: .normal)
            button.setTitleColor(UIColor.gray, for: .normal)
            button.addTarget(self, action: #selector(titlesClick), for: .touchUpInside)
            titlesView.addSubview(button)
            
            if index == 0 {
                button.isEnabled = false
                selectedButton = button
                selectedButton?.setTitleColor(UIColor.red, for: .normal)
                //让按钮内部的Label根据文字来计算内容
                button.titleLabel?.sizeToFit()
            }
        }
    }
    
    /// 主要内容视图
    func setupContentView() {
        automaticallyAdjustsScrollViewInsets = false
        let contentView = UIScrollView()
        contentView.frame = view.bounds
        contentView.delegate = self
        contentView.contentSize = CGSize(width: contentView.frame.size.width * CGFloat(childViewControllers.count), height: 0)
        contentView.isPagingEnabled = true
        view.insertSubview(contentView, at: 0)
        self.contentView = contentView
        //添加第一个控制器的view
        scrollViewDidEndScrollingAnimation(contentView)
    }
    
    /// 点击按钮
    func titlesClick(button: UIButton) {
        selectedButton!.isEnabled = true
        selectedButton!.setTitleColor(UIColor.gray, for: .normal)
        button.isEnabled = false
        selectedButton = button
        selectedButton?.setTitleColor(UIColor.red, for: .normal)
        
        var offset = contentView!.contentOffset
        offset.x = CGFloat(button.tag) * (contentView?.frame.size.width)!
        contentView!.setContentOffset(offset, animated: true)
    }
    
    func rightBarButtonClick() {
        navigationController?.pushViewController(NNSearchController(), animated: true)
    }
    
    func arrowButtonClick(button: UIButton) {
        UIView.animate(withDuration: 0.25) {
            button.imageView?.transform = button.imageView!.transform.rotated(by: CGFloat(Double.pi))
        }
    }
    
    /// MARK: - UIScrollViewDelegate
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        // 取出子控制器
        let vc = childViewControllers[index]
        vc.view.frame.origin.x = scrollView.contentOffset.x
        vc.view.frame.origin.y = 0 // 设置控制器的y值为0(默认为20)
        //设置控制器的view的height值为整个屏幕的高度（默认是比屏幕少20）
        vc.view.frame.size.height = scrollView.frame.size.height
        scrollView.addSubview(vc.view)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
        // 当前索引
        let index = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        // 点击 Button
        let button = titlesView.subviews[index] as! UIButton
        titlesClick(button: button)
    }
    
    /// 懒加载头部试图背景
    private lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.frame = CGRect(x: 0, y: kTitlesViewY, width: NNScreenWidth, height: kTitlesViewH)
        bgView.backgroundColor = UIColor.white
        return bgView
    }()
    
    /// 懒加载头部视图左边几个按钮
    private lazy var titlesView: UIView = {
        let titlesView = UIView()
        titlesView.frame = CGRect(x: 0, y: 0, width: NNScreenWidth - kTitlesViewH, height: kTitlesViewH)
        return titlesView
    }()
    
    /// 懒加载头部视图右部按钮
    private lazy var arrowButton: UIButton = {
        let arrowButton = UIButton()
        arrowButton.frame = CGRect(x: NNScreenWidth - kTitlesViewH, y: 0, width: kTitlesViewH, height: kTitlesViewH)
        arrowButton.setImage(UIImage(named: "icon_ordercenter_arrow_down"), for: .normal)
        arrowButton.addTarget(self, action: #selector(arrowButtonClick), for: .touchUpInside)
        return arrowButton
    }()
}
