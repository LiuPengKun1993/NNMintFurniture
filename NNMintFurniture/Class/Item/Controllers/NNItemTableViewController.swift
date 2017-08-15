//
//  NNItemTableViewController.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/11.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit

let NNItemTableViewCellID = "NNItemTableViewCellID"

// MARK: - 枚举判断 UITableView 类型
enum tableViewType {
    case noHeader
    case haveHeader
}

class NNItemTableViewController: UITableViewController {
    
    var type: tableViewType = .noHeader
    var currentPostion = CGFloat()
    var lastPosition = CGFloat()
    var stopPosition = CGFloat()
    var topBool = Bool()
    var bottomBool = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lastPosition = 0
        stopPosition = 0
        topBool = true
        bottomBool = true
        let nib = UINib(nibName: String(describing: NNItemTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: NNItemTableViewCellID)
        tableView.rowHeight = 110
        if type == .haveHeader {
            title = "导航栏 tableView"
            tableView.sectionHeaderHeight = 180
            tableView.tableHeaderView = shufflingFigureView
        } else {
            title = "导航栏渐变 tableView"
        }
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
    
    // MARK: - 懒加载轮播视图
    private lazy var shufflingFigureView : NNShufflingFigureView = {
        let frame = CGRect(x: 0, y: 0, width: NNScreenWidth, height: 180)
        let imageView = ["shuffling1", "shuffling2", "shuffling3", "shuffling4"]
        let shufflingFigureView = NNShufflingFigureView(frame: frame, images: imageView as NSArray, autoPlay: true, delay: 3, isFromNet: false)
        shufflingFigureView.delegate = self
        return shufflingFigureView
    }()
}

// MARK: - 轮播代理方法
extension NNItemTableViewController: NNShufflingFigureViewDelegate {
    func addShufflingFigureView(addShufflingFigureView: NNShufflingFigureView, iconClick index: NSInteger) {
        print(index)
    }
}

// MARK: - UIScrollViewDelegate 滚动页面时调用
extension NNItemTableViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if type == tableViewType.haveHeader {
            return
        }
        currentPostion = scrollView.contentOffset.y
        if currentPostion > 0 {
            if currentPostion - lastPosition >= 0 {
                if topBool {
                    topBool = false
                    bottomBool = true
                    stopPosition = currentPostion + 64
                }
                lastPosition = currentPostion
                navigationController?.navigationBar.alpha = 1 - currentPostion / 500
            } else {
                if bottomBool {
                    bottomBool = false
                    topBool = true
                    stopPosition = currentPostion + 64
                }
                lastPosition = currentPostion
                navigationController?.navigationBar.alpha = (stopPosition - currentPostion) / 200
            }
        }
    }
}
