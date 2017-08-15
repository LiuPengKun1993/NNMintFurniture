//
//  NNSearchController.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/7.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit

class NNSearchController: NNBaseViewController, NNSearchBarDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.titleView = searchBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
    }

    
    // MARK: - NNSearchBarDelegate 代理
    // MARK: searchBarTextDidChange
    func searchBarTextDidChange(textField: UITextField) {
        print("你输入的是:" + String(describing: textField))
    }
    
    // MARK: searchBarCancelButtonClicked
    func searchBarCancelButtonClicked(searchBar: NNSearchBar) {
        searchBar.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: searchBarTextFieldShouldReturn
    func searchBarTextFieldShouldReturn(textField: UITextField) {
        print("searchBarTextFieldShouldReturn")
    }
    
    // MARK: - 点击屏幕时结束编辑
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.endEditing(true)
    }
    
    // MARK: - 懒加载 searchBar
    private lazy var searchBar : NNSearchBar = {
        let seacrhBar = NNSearchBar()
        seacrhBar.delegate = self
        seacrhBar .becomeFirstResponder()
        seacrhBar.frame = CGRect(x: 0, y: 0, width: NNScreenWidth, height: kSearchBarH)
        return seacrhBar
    }()
}
