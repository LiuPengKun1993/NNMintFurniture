//
//  NNClassificationController.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/7.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit

let NNClassificationControllerID = "NNClassificationControllerID"

class NNClassificationController: NNBaseViewController, UITableViewDelegate, UITableViewDataSource {

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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NNClassificationControllerID)
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        return tableView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension NNClassificationController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NNClassificationControllerID)
        cell?.accessoryType = .disclosureIndicator
        switch indexPath.row {
        case 0:
            cell?.textLabel?.text = "拍照"
        case 1:
            cell?.textLabel?.text = "二维码"
        case 2:
            cell?.textLabel?.text = "图片验证码"
        case 3:
            cell?.textLabel?.text = "圆形验证码输入框"
        case 4:
            cell?.textLabel?.text = "UICollectionView-1"
        default:
            cell?.textLabel?.text = "default"
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            let photoVC = NNPhotoController()
            navigationController?.pushViewController(photoVC, animated: true)
        case 1:
            let qrCodeVC = NNScanCodeController()
            navigationController?.pushViewController(qrCodeVC, animated: true)
        case 2:
            navigationController?.pushViewController(NNValidationController(), animated: true)
        case 3:
            navigationController?.pushViewController(NNValidationCodeController(), animated: true)
        default:
            return
        }
    }
}
