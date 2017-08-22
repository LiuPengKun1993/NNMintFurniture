//
//  NNShufflingFigureView.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/13.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit

// MARK: - 自定义代理方法
@objc protocol NNShufflingFigureViewDelegate:NSObjectProtocol {
    func addShufflingFigureView(addShufflingFigureView:NNShufflingFigureView ,iconClick index:NSInteger)
}

class NNShufflingFigureView: UIView {
    
    var pageControl : UIPageControl?
    var currentPage: NSInteger?
    var images: NSArray?
    var delegate:NNShufflingFigureViewDelegate?
    
    private var imageScrollView : UIScrollView?
    private var currentImgs = NSMutableArray()
    private var autoPlay : Bool?
    private var isFromNet : Bool?
    private var delay : TimeInterval?
    
    // MARK: - 重写get方法
    private var currentImages :NSMutableArray? {
        get{
            currentImgs.removeAllObjects()
            let count = self.images!.count
            var i = NSInteger(self.currentPage!+count-1)%count
            currentImgs.add(self.images![i])
            currentImgs.add(self.images![self.currentPage!])
            i = NSInteger(self.currentPage!+1)%count
            currentImgs.add(self.images![i])
            return currentImgs
        }
    }
    // MARK: - 自定义初始化
    convenience init(frame:CGRect ,images:NSArray, autoPlay:Bool, delay:TimeInterval, isFromNet:Bool){
        self.init(frame: frame)
        self.images = images
        self.autoPlay = autoPlay
        self.isFromNet = isFromNet
        self.delay = delay
        self.currentPage = 0
        createImageScrollView()
        createPageView()
        if images.count < 2 {
            self.autoPlay = false
            pageControl?.isHidden = true
        }
        if self.autoPlay == true {
            startAutoPlay()
        }
    }
    // MARK: - 创建图片滚动视图
    private func createImageScrollView(){
        if images?.count == 0 {
            return
        }
        imageScrollView = UIScrollView(frame: self.bounds)
        imageScrollView?.showsHorizontalScrollIndicator = false
        imageScrollView?.showsVerticalScrollIndicator=false
        imageScrollView?.bounces = false
        imageScrollView?.delegate = self
        imageScrollView?.contentSize = CGSize(width:self.bounds.width*3, height:0)
        imageScrollView?.contentOffset = CGPoint(x: self.frame.width, y:  0)
        imageScrollView?.isPagingEnabled = true
        self.addSubview(imageScrollView!)
        for index in 0..<3 {
            
            let imageView = UIImageView(frame: CGRect(x: self.bounds.width*CGFloat(index), y: 0, width: self.bounds.width, height: self.bounds.height))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NNShufflingFigureView.imageViewClick)))
            if self.isFromNet == true {
            }
            else{
                imageView.image = UIImage(named: self.currentImages![index] as! String);
            }
            imageScrollView?.addSubview(imageView)
        }
    }
    // MARK: - 创建pageControl视图
    private func createPageView(){
        if images?.count == 0 {
            return
        }
        let pageW: CGFloat = 80
        let pageH: CGFloat = 25
        let pageX: CGFloat = self.bounds.width - pageW
        let pageY: CGFloat = self.bounds.height - pageH
        
        pageControl = UIPageControl(frame: CGRect(x: pageX, y: pageY, width: pageW, height: pageH))
        pageControl?.numberOfPages = images!.count
        pageControl?.currentPage = 0
        pageControl?.isUserInteractionEnabled = false
        self.addSubview(pageControl!)
    }
    private func startAutoPlay() {
        self.perform(#selector(NNShufflingFigureView.nextPage), with: nil, afterDelay: delay!)
    }
    func nextPage() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(NNShufflingFigureView.nextPage), object: nil)
        imageScrollView!.setContentOffset(CGPoint(x: 2 * self.frame.width, y: 0), animated: true)
        self.perform(#selector(NNShufflingFigureView.nextPage), with: nil, afterDelay: delay!)
    }
    
    // MARK: - 每次图片滚动时刷新图片
    func refreshImages(){
        for i in 0..<imageScrollView!.subviews.count {
            let imageView = imageScrollView!.subviews[i] as! UIImageView
            if self.isFromNet == true {
                // 图片来自网络
            } else { imageView.image = UIImage(named: self.currentImages![i] as! String);
            }
        }
        imageScrollView!.contentOffset = CGPoint(x: self.frame.width, y: 0)
    }
    
    // MARK: - 点击图片事件
    func imageViewClick(){
        if self.delegate != nil && (self.delegate?.responds(to: #selector(NNShufflingFigureViewDelegate.addShufflingFigureView(addShufflingFigureView:iconClick:)))) != nil {
            self.delegate!.addShufflingFigureView(addShufflingFigureView: self, iconClick: currentPage!)
        }
    }
}

// MARK: - UIScrollViewDelegate 代理
extension NNShufflingFigureView : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {      scrollView.setContentOffset(CGPoint(x: self.frame.width, y: 0), animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let width = self.frame.width
        if x >= 2 * width {
            currentPage = (currentPage!+1) % self.images!.count
            pageControl!.currentPage = currentPage!
            refreshImages()
        }
        if x <= 0 {
            currentPage = (currentPage!+self.images!.count-1) % self.images!.count
            pageControl!.currentPage = currentPage!
            refreshImages()
        }
    }
}
