//
//  NNMeController.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/7.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit

let NNMeControllerID = "NNMeControllerID"

class NNMeController: NNBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    }
    
    // MARK: - 懒加载 UITableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.frame = CGRect(x: 0, y: 0, width: NNScreenWidth, height: NNScreenHeight)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NNMeControllerID)
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        return tableView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension NNMeController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NNMeControllerID)
        cell?.accessoryType = .disclosureIndicator
        switch indexPath.row {
        case 0:
            cell?.textLabel?.text = "SnapKit 用法"
        default:
            cell?.textLabel?.text = "SnapKit 用法"
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(NNSnapKitController(), animated: true)
        default:
            return
        }
    }
}
