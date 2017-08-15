//
//  NNItemScrollView.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/11.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit

class NNItemScrollView: UIViewController, UIScrollViewDelegate, NNItemBtnViewDelegate {
    
    var imageView: UIImageView!
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UIScrollView"
        view.backgroundColor = UIColor.white
        let amplificationBtn = UIBarButtonItem(title: "放大", style: .plain, target: self, action: #selector(NNItemScrollView.amplificationBtnClick))
        let narrowDownBtn = UIBarButtonItem(title: "缩小", style: .plain, target: self, action: #selector(NNItemScrollView.narrowDownBtnClick))
        navigationItem.rightBarButtonItems = [amplificationBtn, narrowDownBtn]
        
        scrollView = UIScrollView(frame: view.frame)
        view.addSubview(scrollView)
        view.addSubview(itemBtnView)
        scrollView.delegate = self

        let image = UIImage(named: "shuffling3")
        imageView = UIImageView(image: image)
        scrollView.addSubview(imageView)
        scrollView.contentSize = image!.size
        
        // 缩放
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 2
    }
    
    // MARK: - 放大缩小
    // MARK: 放大
    func amplificationBtnClick() {
        var zoomScale = scrollView.zoomScale // 当前缩放
        zoomScale += 0.1
        if zoomScale >= scrollView.maximumZoomScale {
            return
        }
        self.scrollView.setZoomScale(zoomScale, animated: true)
    }
    
    // MARK: 缩小
    func narrowDownBtnClick() {
        var zoomScale = scrollView.zoomScale // 当前缩放
        zoomScale -= 0.1
        if zoomScale <= scrollView.minimumZoomScale {
            return
        }
        self.scrollView.setZoomScale(zoomScale, animated: true)
    }
    
    // MARK: - UIScrollViewDelegate 代理
    // MARK: 滚动中
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(#function)
    }
    
    // MARK: 手指触摸开始滚动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print(#function)
    }
    
    // MARK: 手指离开屏幕后，滚动视图滚动开始减速动画
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        scrollView.decelerationRate = scrollView.decelerationRate/2
    }
    
    // MARK: 返回要缩放的View
    func viewForZooming(in scrollView: UIScrollView) -> UIView?  {
        return self.imageView
    }
    
    // MARK: 点击顶部的时间，是否回滚到顶部
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return scrollView.scrollsToTop
    }
    
    // MARK: - 懒加载按钮的父视图
    private lazy var itemBtnView: NNItemBtnView = {
        let itemBtnView = NNItemBtnView()
        itemBtnView.frame = CGRect(x: 30, y: 100, width: 100, height: 100)
        itemBtnView.delegate = self
        return itemBtnView
    }()
}

// MARK: - NNItemBtnViewDelegate 上下左右点击代理
extension NNItemScrollView {
    // MARK: 向左
    func leftBtnClickDelegate() {
        var point = self.scrollView.contentOffset
        point.x += 100
        point.x = point.x >= self.scrollView.contentSize.width ? 0 : point.x
        scrollView.setContentOffset(point, animated: true)
    }
    
    // MARK: 向右
    func rightBtnClickDelegate() {
        var point = self.scrollView.contentOffset
        point.x -= 100
        point.x = point.x <= -NNScreenWidth ? 0 : point.x
        scrollView.setContentOffset(point, animated: true)
    }
    
    // MARK: 向上
    func topBtnClickDelegate() {
        var point = self.scrollView.contentOffset
        point.y += 50
        point.y = point.y >= self.scrollView.contentSize.height ? 0 : point.y
        scrollView.setContentOffset(point, animated: true)
    }
    
    // MARK: 向下
    func bottomBtnClickDelegate() {
        var point = self.scrollView.contentOffset
        point.y -= 50
        point.y = point.y <= -NNScreenHeight ? 0 : point.y
        scrollView.setContentOffset(point, animated: true)
    }
}
