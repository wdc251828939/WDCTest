//
//  MyCell.swift
//  QBSwiftDemo
//
//  Created by lanouhn on 16/3/18.
//  Copyright © 2016年 王大超. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {

    @IBOutlet var iconImageView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var contentLABEL: UILabel!
    @IBOutlet var feelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
            }
    
   
    
        //配置cell
    func configureCellWithModel(model:QBModel) {
        if model.iconUrl != nil {
        
        iconImageView.sd_setImageWithURL(NSURL(string: model.iconUrl))
        }
        nameLabel.text = model.nickName
        contentLABEL.text = model.content
        feelLabel.text = "\(model.smileNumber) 好笑  *  \(model.commentNumber) 评论"
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
