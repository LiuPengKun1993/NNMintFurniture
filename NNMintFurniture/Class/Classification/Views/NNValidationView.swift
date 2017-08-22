//
//  NNValidationView.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/18.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit

class NNValidationView: UIView {
    var charString = String()
    private var charCount:Int = 4
    private var lineCount:Int = 4
    private var charArray:[String] = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
        backgroundColor = randomColor()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGesture)))
        createChars()
    }
    
    // MARK: - 点击事件
    func tapGesture() {
        backgroundColor = randomColor()
        createChars()
    }
    
    // MARK: - 更换随机验证码
    func createChars() -> Void {
        charString = ""
        for _ in 0..<charCount {
            let index = NSInteger(arc4random()) % charArray.count
            charString = charString.appending(charArray[index])
        }
        setNeedsDisplay()
    }
    
    // MARK: - 随机颜色
    func randomColor() -> UIColor {
        return UIColor.init(colorLiteralRed: (Float)(arc4random() % 100) / 100.0, green: (Float)(arc4random() % 100) / 100.0, blue: (Float)(arc4random() % 100) / 100.0, alpha: 0.5)
    }
    
    // MARK: - 绘制图形验证码
    override func draw(_ rect: CGRect) {
        if charString.isEmpty {
            return;
        }
        
        let textString:String = charString
        let charSize = textString.substring(to: textString.startIndex).size(attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14)])
        let width = rect.size.width / CGFloat(charCount) - charSize.width - 15;
        let hight = rect.size.height - charSize.height;
        var point: CGPoint
        
        var pointX: CGFloat
        var pointY: CGFloat
        for i in 0..<textString.characters.count {
            let char = CGFloat(i)
            pointX = (CGFloat)(arc4random() % UInt32(Float(width))) + rect.size.width / (CGFloat)(textString.characters.count) * char
            pointY = (CGFloat)(arc4random() % UInt32(Float(hight)))
            point = CGPoint(x: pointX, y: pointY)
            let charStr = textString[textString.index(textString.startIndex, offsetBy:i)]
            let string = String(charStr)
            string.draw(at: point,withAttributes:([NSFontAttributeName : UIFont.systemFont(ofSize: 14)]))
        }
        drawLine(rect)
    }
    
    // MARK: - 绘制干扰线
    func drawLine(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context!.setLineWidth(1.0)
        var pointX = 0.0
        var pointY = 0.0
        for _ in 0..<lineCount {
            context!.setStrokeColor(randomColor().cgColor)
            pointX = Double(arc4random() % UInt32(Float(rect.size.width)))
            pointY = Double(arc4random() % UInt32(Float(rect.size.height)))
            context?.move(to: CGPoint(x: pointX, y: pointY))
            pointX = Double(CGFloat(arc4random() % UInt32(Float(rect.size.width))))
            pointY = Double(CGFloat(arc4random() % UInt32(Float(rect.size.height))))
            context?.addLine(to: CGPoint(x: pointX, y: pointY))
            context!.strokePath()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
