//
//  NNTestViewController.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/10.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit

class NNTestViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsetsMake(kTitlesViewY + kTitlesViewH, 0, tabBarController!.tabBar.frame.size.height, 0)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.scrollIndicatorInsets = tableView.contentInset
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!

        let type = indexPath.row % 4
        
        switch type {
        case 0:
            cell  = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.text = "Default"
            cell.accessoryType = .none
            cell.selectionStyle = .none
        case 1:
            cell  = UITableViewCell(style: .value1, reuseIdentifier: nil)
            cell.textLabel?.text = "Value1"
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .blue
        case 2:
            cell  = UITableViewCell(style: .value2, reuseIdentifier: nil)
            cell.textLabel?.text = "Value2"
            cell.accessoryType = .detailDisclosureButton
            cell.selectionStyle = .gray
        case 3:
            cell  = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
            cell.textLabel?.text = "Subtitle"
            cell.accessoryType = .checkmark
            cell.selectionStyle = .default
        default:
            cell.accessoryType = .detailButton
            cell.textLabel?.text = "default"
        }
        // 缩进
        cell.indentationLevel = indexPath.row
        // 缩进的基数, 默认10.0
        cell.indentationWidth = 4
        cell.imageView?.image = UIImage(named: "icon_mine_membercard")
        cell.detailTextLabel?.text = "UITableViewCellStyle"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
