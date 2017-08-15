//
//  NNItemBtnView.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/15.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - 自定义代理方法
@objc protocol NNItemBtnViewDelegate:NSObjectProtocol {
    func leftBtnClickDelegate()
    func rightBtnClickDelegate()
    func topBtnClickDelegate()
    func bottomBtnClickDelegate()
}

class NNItemBtnView: UIView {
    weak var delegate: NNItemBtnViewDelegate?

    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = UIColor.white
        alpha = 0.6
        layer.masksToBounds = true
        layer.cornerRadius = 30
        
        addSubview(leftBtn)
        addSubview(rightBtn)
        addSubview(topBtn)
        addSubview(bottomBtn)
        
        topBtn.snp.makeConstraints { (make) in
            make.width.equalTo(40)
            make.height.equalTo(30)
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }
        
        leftBtn.snp.makeConstraints { (make) in
            make.width.equalTo(topBtn)
            make.height.equalTo(topBtn)
            make.centerY.equalTo(self)
            make.left.equalTo(self)
        }
        
        rightBtn.snp.makeConstraints { (make) in
            make.width.equalTo(topBtn)
            make.height.equalTo(topBtn)
            make.centerY.equalTo(self)
            make.right.equalTo(self)
        }
        
        bottomBtn.snp.makeConstraints { (make) in
            make.width.equalTo(topBtn)
            make.height.equalTo(topBtn)
            make.centerX.equalTo(topBtn)
            make.bottom.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func leftBtnClick() {
        if self.delegate != nil && (self.delegate?.responds(to: #selector(NNItemBtnViewDelegate.leftBtnClickDelegate))) != nil {
            delegate?.leftBtnClickDelegate()
    }
    }

    func rightBtnClick() {
        if self.delegate != nil && (self.delegate?.responds(to: #selector(NNItemBtnViewDelegate.rightBtnClickDelegate))) != nil {
            delegate?.rightBtnClickDelegate()
        }
    }
    
    func topBtnClick() {
        if self.delegate != nil && (self.delegate?.responds(to: #selector(NNItemBtnViewDelegate.topBtnClickDelegate))) != nil {
            delegate?.topBtnClickDelegate()
        }
    }
    
    func bottomBtnClick() {
        if self.delegate != nil && (self.delegate?.responds(to: #selector(NNItemBtnViewDelegate.bottomBtnClickDelegate))) != nil {
            delegate?.bottomBtnClickDelegate()
        }
    }

    private lazy var leftBtn: UIButton = {
        var leftBtn = UIButton()
        leftBtn.setTitle("向左", for: .normal)
        leftBtn.backgroundColor = UIColor.red
        leftBtn.setTitleColor(UIColor.white, for: .normal)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        leftBtn.addTarget(self, action: #selector(leftBtnClick), for: .touchUpInside)
        return leftBtn
    }()
    
    private lazy var rightBtn: UIButton = {
        let rightBtn = UIButton()
        rightBtn.setTitle("向右", for: .normal)
        rightBtn.backgroundColor = UIColor.red
        rightBtn.setTitleColor(UIColor.white, for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        rightBtn.addTarget(self, action: #selector(rightBtnClick), for: .touchUpInside)
        return rightBtn
    }()
    
    private lazy var topBtn: UIButton = {
        let topBtn = UIButton()
        topBtn.setTitle("向上", for: .normal)
        topBtn.backgroundColor = UIColor.red
        topBtn.setTitleColor(UIColor.white, for: .normal)
        topBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        topBtn.addTarget(self, action: #selector(topBtnClick), for: .touchUpInside)
        return topBtn
    }()
    
    private lazy var bottomBtn: UIButton = {
        let bottomBtn = UIButton()
        bottomBtn.setTitle("向下", for: .normal)
        bottomBtn.backgroundColor = UIColor.red
        bottomBtn.setTitleColor(UIColor.white, for: .normal)
        bottomBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        bottomBtn.addTarget(self, action: #selector(bottomBtnClick), for: .touchUpInside)
        return bottomBtn
    }()
}
