//
//  NNValidationController.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/21.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit

class NNValidationController: NNBaseViewController {
    
    let validationView = NNValidationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "图片验证码"
        setupUI()
    }
    
    // MARK: - setupUI
    func setupUI() {
        view.addSubview(validationView)
        validationView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(100)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        validationView.createChars()
        
        view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.top.equalTo(validationView).offset(50)
            make.centerX.equalTo(view)
        }
        
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.top.equalTo(textField).offset(50)
            make.height.equalTo(30)
            make.centerX.equalTo(view)
        }
    }
    
    // MARK: - 验证按钮点击事件
    func btnClick() {
        // 不区分大小写
        let result = textField.text?.range(of: validationView.charString, options: String.CompareOptions.caseInsensitive)

        if result != nil {
            let alert = UIAlertController.init(title: "图形验证码", message: "验证成功", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController.init(title: "图形验证码", message: "验证失败", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - 懒加载
    private lazy var textField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "输入验证码"
        textField.borderStyle = UITextBorderStyle.line
        return textField
    }()
    
    private lazy var button : UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setTitle("验证", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return button
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
