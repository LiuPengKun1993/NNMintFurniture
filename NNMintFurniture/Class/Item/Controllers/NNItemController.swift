//
//  NNItemController.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/7.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit

class NNItemController: NNBaseViewController, UITableViewDelegate, UITableViewDataSource {
    private var rightBarBtnSelected = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // 添加按钮
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onRightBtn(sender:)))
        navigationItem.rightBarButtonItem = addBtn;

        view.addSubview(tableView)
    }
    
    func onRightBtn(sender: UIButton) {
        rightBarBtnSelected = !rightBarBtnSelected
        if rightBarBtnSelected == true {
            
        } else {
            
        }
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
            cell?.textLabel?.text = "轮播图 tableView"
        case 1:
            cell?.textLabel?.text = "导航栏渐变 tableView"
        case 2:
            cell?.textLabel?.text = "UIScrollView"
        case 3:
            cell?.textLabel?.text = "UICollectionView瀑布流"
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
            let tableViewVC = NNItemTableViewController()
            tableViewVC.type = tableViewType.haveHeader
            navigationController?.pushViewController(tableViewVC, animated: true)
        case 1:
            let tableViewVC = NNItemTableViewController()
            tableViewVC.type = tableViewType.noHeader
            navigationController?.pushViewController(tableViewVC, animated: true)
        case 2:
            navigationController?.pushViewController(NNItemScrollView(), animated: true)
        case 3:
            navigationController?.pushViewController(NNItemCollectionViewController(), animated: true)
        default:
            return
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.alpha = 1
    }
    
    // MARK: - 懒加载 tableView
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
