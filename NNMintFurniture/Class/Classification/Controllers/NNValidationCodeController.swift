//
//  NNValidationCodeController.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/21.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit

class NNValidationCodeController: NNBaseViewController {
    let validationCodeView = NNValidationCodeView(frame: CGRect(x: 60, y: 100, width: 300, height: 40))

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "圆形验证码输入框"
        setupUI()
    }
    
    // MARK: - setupUI
    func setupUI() {
        view.addSubview(validationCodeView)
        
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.top.equalTo(validationCodeView).offset(100)
            make.height.equalTo(30)
            make.centerX.equalTo(view)
        }
    }
    
    // MARK: - 验证按钮点击事件
    func btnClick() {
        if validationCodeView.codeTextField.text == "666666" {
            let alert = UIAlertController.init(title: "圆形验证码", message: "验证成功", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController.init(title: "圆形验证码", message: "验证失败", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - 懒加载
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
