//
//  NNSearchBar.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/10.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit

// MARK: - NNSearchBarDelegate
protocol NNSearchBarDelegate: NSObjectProtocol {
    func searchBarTextDidChange(textField: UITextField)
    func searchBarCancelButtonClicked(searchBar:NNSearchBar)
    func searchBarTextFieldShouldReturn(textField: UITextField)
}

class NNSearchBar: UIView, UITextFieldDelegate {
    weak var delegate: NNSearchBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cancelBtn)
        // 添加搜索输入框
        addSubview(textField)
    }
    
    // MARK: - 输入文本框输入字体时调用
    func searchBarTextDidChange(textField: UITextField) {
        delegate?.searchBarTextDidChange(textField: textField)
    }
    
    // MARK: - 点击取消按钮
    func cancelBtnClick() {
        delegate?.searchBarCancelButtonClicked(searchBar: self)
    }
    
    // MARK: - 懒加载
    // MARK: 懒加载搜索输入框
    private lazy var textField: NNSearchTextField = {
        let textField = NNSearchTextField()
        textField.frame = CGRect(x: 0, y: 0, width: NNScreenWidth - 60, height: kSearchBarH)
        textField.delegate = self
        textField.addTarget(self, action: #selector(searchBarTextDidChange), for: .editingChanged)
       return textField
    }()
    
    // MARK: 懒加载取消按钮
    private lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton()
        cancelBtn.frame = CGRect(x: NNScreenWidth - 60, y: 0, width: 40, height: kSearchBarH)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(UIColor.white, for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        return cancelBtn
    }()
    
    // MARK: - UITextFieldDelegate - 点击键盘 search
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return ((delegate?.searchBarTextFieldShouldReturn(textField: textField)) != nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
