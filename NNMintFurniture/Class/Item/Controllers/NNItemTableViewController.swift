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
        tableView.sectionHeaderHeight = 180
        tableView.tableHeaderView = shufflingFigureView
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> NNItemTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NNItemTableViewCellID, for: indexPath)
        return cell as! NNItemTableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - 懒加载轮播视图
    private lazy var shufflingFigureView : NNShufflingFigureView = {
        let frame = CGRect(x: 0, y: 0, width: NNScreenWidth, height: 180)
        let imageView = ["shuffling1", "shuffling2", "shuffling3", "shuffling4"]
        let shufflingFigureView = NNShufflingFigureView(frame: frame, images: imageView as NSArray, autoPlay: true, delay: 3, isFromNet: false)
        shufflingFigureView.delegate = self
        return shufflingFigureView
    }()
}

//MARK - 轮播代理方法
extension NNItemTableViewController: NNShufflingFigureViewDelegate {
    func addShufflingFigureView(addShufflingFigureView: NNShufflingFigureView, iconClick index: NSInteger) {
        print(index)
    }
}
