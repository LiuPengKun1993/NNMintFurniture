//
//  NNItemTableViewCell.swift
//  NNMintFurniture
//
//  Created by 柳钟宁 on 2017/8/11.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

import UIKit

class NNItemTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func likeBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
