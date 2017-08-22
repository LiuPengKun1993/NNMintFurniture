//
//  NNSnapKitController.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/21.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit

class NNSnapKitController: NNBaseViewController {
    private let redView           = UIView()
    private let blueView          = UIView()
    private let blackView         = UIView()
    private let cyanView          = UIView()
    private let yellowView        = UIView()
    private let whiteView         = UIView()

    private let headerImage       = UIImageView()
    private let nickNameLabel     = UILabel()
    private let focusLabel        = UILabel()
    private let lineView          = UIView()
    private let numberTextField   = UITextField()
    private let passwordTextField = UITextField()
    private let secondLineView    = UIView()
    private let submitButton      = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SnapKit 用法"
        view.backgroundColor = UIColor.gray
        navigationController?.navigationBar.isTranslucent = false
        addRedView()
        addBlueView()
        addBlackView()
        addCyanView()
        addYellowView()
        
        addWhiteView()
        
        addHeaderImageView()
        addNickNameLabel()
        addFocusLabel()
        addLineView()
        addNumberTextField()
        addPasswordTextField()
        addSecondLineView()
        addSubmitButton()
    }
    
    func addRedView() {
        redView.backgroundColor = UIColor.red
        view.addSubview(redView)
        
        // redView 距离父视图四条边的距离都是 50
        redView.snp.makeConstraints { (make) in
            make.edges.equalTo(view).inset(50)
        }
    }
    
    func addBlueView() {
        blueView.backgroundColor = UIColor.blue
        view.addSubview(blueView)
        
        // blueView 左边距离父视图为 0；上边距离父视图为 0；size 是(50，50)
        blueView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
    }
    
    func addBlackView() {
        blackView.backgroundColor = UIColor.black
        view.addSubview(blackView)
        
        // blackView 左边和 redView 的右边距离为 0；大小与 blueView 相同；且与 blueView 上对齐
        blackView.snp.makeConstraints { (make) in
            make.left.equalTo(redView.snp.right)
            make.size.equalTo(blueView)
            make.top.equalTo(blueView)
        }
    }
    
    func addCyanView() {
        cyanView.backgroundColor = UIColor.cyan
        view.addSubview(cyanView)
        
        // cyanView 与 blueView 左对齐；cyanView 的顶部距离 redView 的底部 10；cyanView 的高是40；cyanView 与 blueView 等宽
        cyanView.snp.makeConstraints { (make) in
            make.trailing.equalTo(blueView)
            make.top.equalTo(redView.snp.bottom).offset(10)
            make.height.equalTo(40)
            make.width.equalTo(blueView)
        }
    }
    
    func addYellowView() {
        yellowView.backgroundColor = UIColor.yellow
        view.addSubview(yellowView)
        
        // yellowView 顶部与 redView 的底部对齐；yellowView 与 blackView 左对齐；yellowView 与 blueView 相同大小
        yellowView.snp.makeConstraints { (make) in
            make.top.equalTo(redView.snp.bottom)
            make.trailing.equalTo(blackView)
            make.size.equalTo(blueView)
        }
    }
    
    func addWhiteView() {
        whiteView.backgroundColor = UIColor.white
        redView.addSubview(whiteView)
        
        // whiteView 的父视图是 redView，距离父视图四条边的距离分别是（30，10，30，10）
        
        whiteView.snp.makeConstraints { (make) in
            // 第一种方式
            make.edges.equalTo(redView).inset(UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10))
            // 第二种方式
//            make.top.equalTo(redView).offset(30)
//            make.left.equalTo(redView).offset(10)
//            make.bottom.equalTo(redView).offset(-30)
//            make.right.equalTo(redView).offset(-10)
            // 第三种方式
//            make.top.left.bottom.right.equalTo(redView).inset(UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10))
        }
    }
    
    func addHeaderImageView() {
        headerImage.image = UIImage(named: "header")
        whiteView.addSubview(headerImage)
        headerImage.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 60, height: 60))
            make.left.equalTo(whiteView).offset(10)
            make.top.equalTo(whiteView).offset(10)
        }
    }
    
    func addNickNameLabel() {
        nickNameLabel.text = "n以梦为马"
        nickNameLabel.textColor = UIColor.gray
        nickNameLabel.font = UIFont.systemFont(ofSize: 15)
        whiteView.addSubview(nickNameLabel)
        nickNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(headerImage)
            make.left.equalTo(headerImage.snp.right).offset(10)
            make.size.equalTo(CGSize(width: 100, height: 30))
        }
    }
    
    func addFocusLabel() {
        focusLabel.text = "0你关注/0关注你"
        focusLabel.textColor = UIColor.gray
        focusLabel.font = UIFont.systemFont(ofSize: 14)
        whiteView.addSubview(focusLabel)
        focusLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nickNameLabel.snp.bottom)
            make.left.equalTo(nickNameLabel)
            make.size.equalTo(CGSize(width: 150, height: 30))
        }
    }
    
    func addLineView() {
        lineView.backgroundColor = UIColor.gray
        whiteView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(headerImage.snp.bottom).offset(10)
            make.trailing.equalTo(whiteView).offset(-10)
            make.leading.equalTo(whiteView).offset(10)
            make.height.equalTo(0.5)
        }
    }
    
    func addNumberTextField() {
        numberTextField.placeholder = "请输入电话号码"
        numberTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        numberTextField.keyboardType = UIKeyboardType.numberPad
        numberTextField.font = UIFont.systemFont(ofSize: 14)
        whiteView.addSubview(numberTextField)
        numberTextField.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.left.equalTo(lineView)
            make.right.equalTo(lineView)
            make.height.equalTo(30)
        }
    }
    
    func addPasswordTextField() {
        passwordTextField.placeholder = "请输入密码"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        passwordTextField.keyboardType = UIKeyboardType.numberPad
        passwordTextField.font = UIFont.systemFont(ofSize: 14)
        whiteView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(numberTextField.snp.bottom).offset(10)
            make.left.equalTo(numberTextField)
            make.right.equalTo(numberTextField)
            make.height.equalTo(numberTextField)
        }
    }
    
    func addSecondLineView() {
        secondLineView.backgroundColor = UIColor.gray
        whiteView.addSubview(secondLineView)
        secondLineView.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.left.equalTo(lineView)
            make.right.equalTo(lineView)
            make.height.equalTo(lineView)
        }
    }
    
    func addSubmitButton() {
        submitButton.setTitle("提交信息", for: .normal)
        submitButton.setTitleColor(UIColor.blue, for: .normal)
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        whiteView.addSubview(submitButton)
        submitButton.snp.makeConstraints { (make) in
            make.top.equalTo(secondLineView.snp.bottom).offset(10)
            make.centerX.equalTo(whiteView)
            make.size.equalTo(CGSize(width: 100, height: 30))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        numberTextField.endEditing(true)
        passwordTextField.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
