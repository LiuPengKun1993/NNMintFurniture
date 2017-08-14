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
    
    /// NNSearchBarDelegate : searchBarTextDidChange
    func searchBarTextDidChange(textField: UITextField) {
        print("你输入的是:" + String(describing: textField))
    }
    /// searchBarCancelButtonClicked
    func searchBarCancelButtonClicked(searchBar: NNSearchBar) {
        searchBar.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
    
    /// searchBarTextFieldShouldReturn
    func searchBarTextFieldShouldReturn(textField: UITextField) {
        print("searchBarTextFieldShouldReturn")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.endEditing(true)
    }
    
    /// 懒加载
    private lazy var searchBar : NNSearchBar = {
        let seacrhBar = NNSearchBar()
        seacrhBar.delegate = self
        seacrhBar .becomeFirstResponder()
        seacrhBar.frame = CGRect(x: 0, y: 0, width: NNScreenWidth, height: kSearchBarH)
        return seacrhBar
    }()
}
