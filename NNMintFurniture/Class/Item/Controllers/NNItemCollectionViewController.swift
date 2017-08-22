//
//  NNItemCollectionViewController.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/15.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit

let NNItemCollectionViewControllerID = "NNItemCollectionViewControllerID"

class NNItemCollectionViewController: NNBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UICollectionView瀑布流"
        // 布局
        let layout = NNItemCollectionViewFlowLayout()
        // 创建collectionView
        let collectionView = UICollectionView.init(frame: view.bounds, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NNItemCollectionViewControllerID)
    }
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension NNItemCollectionViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: 多少组
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    // MARK: 每一组有多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    // MARK: Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NNItemCollectionViewControllerID, for: indexPath)
        cell.backgroundColor = UIColor.blue
        return cell
    }
}
