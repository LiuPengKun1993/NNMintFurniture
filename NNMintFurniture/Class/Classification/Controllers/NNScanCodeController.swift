//
//  NNScanCodeController.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/18.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit
import AVFoundation
private let scanAnimationDuration = 3.0 // 扫描时长

class NNScanCodeController: NNBaseViewController {

    private var promptLabel = UILabel()
    private var scanImageView = UIImageView()
    
    var scanResult = UILabel()
    var scanLine = UIImageView()
    var scanSession : AVCaptureSession?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startScan()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "扫描二维码"
        let rightBtn = UIBarButtonItem(title: "相册", style: .plain, target: self, action: #selector(rightBtnClick))
        rightBtn.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = rightBtn
        addScanImageView()
        addPromptLabel()
        setupScanSession()
    }
    
    // MARK: - 扫面框
    func addScanImageView() {
        scanImageView.image = UIImage(named: "QRCode")
        view.addSubview(scanImageView)
        scanImageView.snp.makeConstraints { (make) in
            make.top.equalTo(200)
            make.height.width.equalTo(250)
            make.centerX.equalTo(view)
        }
        
        scanImageView.addSubview(scanLine)
        scanLine.frame = CGRect(x: 0, y: 0, width: 250, height: 3)
        scanLine.image = UIImage(named: "QRCode_ScanLine")
    }
    
    // MARK: - 提示文本
    func addPromptLabel() {
        promptLabel.text = "将二维码/条形码放入框内，即可自动扫描"
        promptLabel.font = UIFont.systemFont(ofSize: 13)
        promptLabel.textColor = UIColor.cyan
        view.addSubview(promptLabel)
        promptLabel.snp.makeConstraints { (make) in
            make.width.equalTo(scanImageView)
            make.centerX.equalTo(scanImageView)
            make.height.equalTo(30)
            make.top.equalTo(scanImageView.snp.bottom).offset(20)
        }
        
        scanResult.text = "此处显示扫描结果"
        scanResult.font = UIFont.systemFont(ofSize: 13)
        scanResult.textColor = UIColor.cyan
        scanResult.textAlignment = NSTextAlignment.center
        view.addSubview(scanResult)
        scanResult.snp.makeConstraints { (make) in
            make.width.equalTo(scanImageView)
            make.centerX.equalTo(scanImageView)
            make.height.equalTo(30)
            make.bottom.equalTo(scanImageView.snp.top).offset(-20)
        }
    }
    
    // MARK: - 扫描设备设置
    func setupScanSession() {
        do {
            // 设置捕捉设备
            let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            // 设置设备输入输出
            let input = try AVCaptureDeviceInput(device: device)
            let output = AVCaptureMetadataOutput()
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            // 设置会话
            let  scanSession = AVCaptureSession()
            scanSession.canSetSessionPreset(AVCaptureSessionPresetHigh)
            
            if scanSession.canAddInput(input) {
                scanSession.addInput(input)
            }
            
            if scanSession.canAddOutput(output) {
                scanSession.addOutput(output)
            }
            
            // 设置扫描类型(二维码和条形码)
            output.metadataObjectTypes = [
                AVMetadataObjectTypeQRCode,
                AVMetadataObjectTypeCode39Code,
                AVMetadataObjectTypeCode128Code,
                AVMetadataObjectTypeCode39Mod43Code,
                AVMetadataObjectTypeEAN13Code,
                AVMetadataObjectTypeEAN8Code,
                AVMetadataObjectTypeCode93Code]
            
            // 预览图层
            let scanPreviewLayer = AVCaptureVideoPreviewLayer(session:scanSession)
            scanPreviewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
            scanPreviewLayer!.frame = view.layer.bounds
            
            view.layer.insertSublayer(scanPreviewLayer!, at: 0)
            
            // 设置扫描区域
            NotificationCenter.default.addObserver(forName: NSNotification.Name.AVCaptureInputPortFormatDescriptionDidChange, object: nil, queue: nil, using: { (noti) in
                output.rectOfInterest = (scanPreviewLayer?.metadataOutputRectOfInterest(for:self.scanImageView.frame))!
            })
            // 保存会话
            self.scanSession = scanSession
            
        } catch {
            // 摄像头不可用
            return
        }
    }
    // MARK: - “相册”按钮点击事件
    func rightBtnClick() {
        guard UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) else {
            return
        }
        
        let imageVC = UIImagePickerController()
        imageVC.allowsEditing = true
        imageVC.delegate = self
        self.present(imageVC, animated: true, completion: nil)
    }
    
    // MARK: - 开始扫描
    fileprivate func startScan() {
        scanLine.layer.add(scanAnimation(), forKey: "scan")
        guard let scanSession = scanSession else { return }
        if !scanSession.isRunning {
            scanSession.startRunning()
        }
    }
    
    // MARK: - 扫描动画
    private func scanAnimation() -> CABasicAnimation {
        let startPoint = CGPoint(x: scanLine .center.x  , y: 2)
        let endPoint = CGPoint(x: scanLine.center.x, y: 250 - 2)
        
        let translation = CABasicAnimation(keyPath: "position")
        translation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        translation.fromValue = NSValue(cgPoint: startPoint)
        translation.toValue = NSValue(cgPoint: endPoint)
        translation.duration = scanAnimationDuration
        translation.repeatCount = MAXFLOAT
        translation.autoreverses = true
        return translation
    }
    
    deinit {
        // 移除通知
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate 扫描捕捉完成
extension NNScanCodeController : AVCaptureMetadataOutputObjectsDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        // 停止扫描
        scanLine.layer.removeAllAnimations()
        scanSession!.stopRunning()
        
        // 扫完完成
        if metadataObjects.count > 0 {
            if let resultObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
                print(resultObj.stringValue)
                scanResult.text = "扫描结果:" + resultObj.stringValue
            }
        }
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension NNScanCodeController : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // 判断是否能取到图片
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        // 转成ciimage
        guard let ciimage = CIImage(image: image) else {
            return
        }
        // 从选中的图片中读取二维码
        // 创建探测器
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy : CIDetectorAccuracyLow])
        let resoult = (detector?.features(in: ciimage))!
        scanResult.text = "无法识别"
        for result in resoult {
            guard (result as! CIQRCodeFeature).messageString != nil else {
                return
            }
            
            scanResult.text = "扫描结果:" + (result as! CIQRCodeFeature).messageString!
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
