//
//  NNItemController.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/7.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit

class NNItemController: NNBaseViewController, UITableViewDelegate, UITableViewDataSource, NNSearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        cell?.accessoryType = .disclosureIndicator
        switch indexPath.row {
        case 0:
            cell?.textLabel?.text = "UITableView"
        case 1:
            cell?.textLabel?.text = "UIScrollView"
        case 2:
            cell?.textLabel?.text = "UICollectionView-0"
        case 3:
            cell?.textLabel?.text = "UICollectionView-1"
        default:
            cell?.textLabel?.text = "default"
        }
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(NNItemTableViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(NNItemScrollView(), animated: true)
        case 2:
            navigationController?.pushViewController(NNItemCollectionViewController(), animated: true)
        case 3:
            navigationController?.pushViewController(NNItemCollectionViewController(), animated: true)
        default:
            return
        }
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
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.frame = CGRect(x: 0, y: 0, width: NNScreenWidth, height: NNScreenHeight)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        return tableView
    }()
}
