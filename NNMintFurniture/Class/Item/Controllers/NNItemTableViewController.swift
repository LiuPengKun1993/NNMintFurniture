//
//  NNItemTableViewController.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/11.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit

let NNItemTableViewCellID = "NNItemTableViewCellID"

class NNItemTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UITableView"
        let nib = UINib(nibName: String(describing: NNItemTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: NNItemTableViewCellID)
        tableView.rowHeight = 110
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> NNItemTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NNItemTableViewCellID, for: indexPath)
        return cell as! NNItemTableViewCell
    }
}
