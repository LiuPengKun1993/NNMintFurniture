//
//  NNSearchTextField.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/10.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit

class NNSearchTextField: UITextField {
    
    /// 初始化 NNSearchTextField
    override init(frame: CGRect) {
        super .init(frame: frame)
        leftView = leftV
        leftViewMode = UITextFieldViewMode.always
        placeholder = "搜索商品、专题"
        background = UIImage.init(named: "sousuo")
        font = UIFont.systemFont(ofSize: 14)
        returnKeyType = UIReturnKeyType.search
        enablesReturnKeyAutomatically = true
    }
    
    /// 懒加载左边的搜索图片
    private lazy var leftV: UIView = {
        let leftV = UIView()
        let leftImage = UIImageView()
        let image = UIImage.init(named: "fangdajing")
        leftV.frame = CGRect(x: 5, y: 0, width: (image?.size.width)! + 15, height: (image?.size.height)!)
        leftImage.frame = CGRect(x: 5, y: 0, width: (image?.size.width)!, height: (image?.size.height)!)
        leftImage.image = image
        leftV.addSubview(leftImage)
        return leftV
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
