//
//  NNItemCollectionViewFlowLayout.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/18.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit

class NNItemCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    // 列数
    private var columnCountDefault : Int = 4
    // 列之间的间距
    private var columnMargin : CGFloat = 10.0
    // 行之间的间距
    private var itemMargin : CGFloat = 10.0
    // 边缘间距
    private var edgeInsetsDefault : UIEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
    // 所有 cell 的布局属性
    fileprivate var attrsArray = [UICollectionViewLayoutAttributes]()
    // 存放所有列的当前高度
    lazy var columnHeightsAry = [CGFloat]()
    
    // MARK: - 更新布局
    override func prepare() {
        super.prepare()
        // 清除所有的布局属性
        attrsArray.removeAll()
        columnHeightsAry.removeAll()
        
        for _ in 0 ..< columnCountDefault {
            columnHeightsAry.append(edgeInsetsDefault.top)
        }
        
        let sections : Int = (collectionView?.numberOfSections)!
        for num in 0 ..< sections {
            let count : Int = (collectionView?.numberOfItems(inSection: num))!
            for i in 0 ..< count {
                let indexpath : NSIndexPath = NSIndexPath.init(item: i, section: num)
                let attrs = layoutAttributesForItem(at: indexpath as IndexPath)!
                attrsArray.append(attrs)
            }
        }
    }
    
    // MARK: - cell 对应的布局属性
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let attrs = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        let collectionWidth = collectionView?.frame.size.width
        // 获得所有 item 的宽度
        let itemW = (collectionWidth! - edgeInsetsDefault.left - edgeInsetsDefault.right - CGFloat(columnCountDefault-1) * columnMargin) / CGFloat(columnCountDefault)
        let itemH = 50 + arc4random_uniform(100)
        
        // 找出高度最短那一列
        var dextColum : Int = 0
        var minH = columnHeightsAry[0]
        for i in 1 ..< columnCountDefault{
            // 取出第 i 列的高度
            let columnH = columnHeightsAry[i]
            
            if minH > columnH {
                minH = columnH
                dextColum = i
            }
        }
        
        let x = edgeInsetsDefault.left + CGFloat(dextColum) * (itemW + columnMargin)
        var y = minH
        if y != edgeInsetsDefault.top{
            y = y + itemMargin
        }
        attrs.frame = CGRect(x: x, y: y, width: itemW, height: CGFloat(itemH))
        // 更新最短那列高度
        columnHeightsAry[dextColum] = attrs.frame.maxY
        return attrs
    }
    
    // MARK: - 返回所有列的高度
    override var collectionViewContentSize: CGSize {
        
        var maxHeight = columnHeightsAry[0]
        for i in 1 ..< columnCountDefault {
            let columnHeight = columnHeightsAry[i]
            if maxHeight < columnHeight {
                maxHeight = columnHeight
            }
        }
        return CGSize.init(width: 0, height: maxHeight + edgeInsetsDefault.bottom)
    }
    
    // MARK: - item 的 frame
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrsArray
    }
}
