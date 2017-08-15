//
//  NNConst.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/10.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit


// 网络请求参数 offset：从第几条开始加载；limit：每次加载多少条
let NNGender = "gender"
let NNGeneration = "generation"
let NNLimit = "limit"
let NNOffset = "offset"

let NNBoHeURL = "http://api.bohejiaju.com/"

// 屏幕的宽
let NNScreenWidth = UIScreen.main.bounds.size.width
// 屏幕的高
let NNScreenHeight = UIScreen.main.bounds.size.height

// 顶部标题的y
let kTitlesViewY: CGFloat = 64
// 顶部标题的高度
let kTitlesViewH: CGFloat = 36
// 搜索框高度
let kSearchBarH: CGFloat = 30


let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
let green = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
let alpha = CGFloat(arc4random_uniform(255))/CGFloat(255.0)

// 随机颜色
let randomColor = UIColor.init(red:red, green:green, blue:blue , alpha: alpha)


