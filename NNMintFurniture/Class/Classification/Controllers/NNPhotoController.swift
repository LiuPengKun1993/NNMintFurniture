//
//  NNPhotoController.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/18.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit

class NNPhotoController: NNBaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private var imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "拍照"
        addImageView()
        addPromptLabel()
    }
    
    // MARK: - 添加头像
    func addImageView() {
        view.addSubview(imageView)
        imageView.image = UIImage(named: "shuffling2")
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.top.equalTo(100)
            make.centerX.equalTo(view)
        }
        imageView.contentMode = UIViewContentMode.scaleToFill
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changePicture)))
    }
    
    // MARK: - 添加提示文本
    func addPromptLabel() {
        let promptLabel = UILabel()
        view.addSubview(promptLabel)
        promptLabel.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalTo(imageView)
        }
        promptLabel.text = "点击图片"
        promptLabel.textAlignment = NSTextAlignment.center
    }
    

    // MARK: - 点击头像按钮，更换头像
    func changePicture() {
        let alertcontroller = UIAlertController(title: "请选择相片", message: nil, preferredStyle: .actionSheet)
        let alertaction = UIAlertAction(title: "从相册选取", style: .destructive) { (action) in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        let alertaction2 = UIAlertAction(title: "拍照", style: .destructive) { (action) in
            if (!UIImagePickerController.isSourceTypeAvailable(.camera)) {
                print("设备不支持相机")
                return
            }
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        let alertAction3 = UIAlertAction(title: "取消", style: .cancel) { (action) in
            print("取消")
        }
        
        alertcontroller.addAction(alertaction)
        alertcontroller.addAction(alertaction2)
        alertcontroller.addAction(alertAction3)
        present(alertcontroller, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
