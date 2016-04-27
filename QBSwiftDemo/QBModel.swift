//
//  QBModel.swift
//  QBSwiftDemo
//
//  Created by lanouhn on 16/3/18.
//  Copyright © 2016年 王大超. All rights reserved.
//

import UIKit

class QBModel: NSObject {

    //属性
    var iconUrl:String!
    var nickName:String!
    
    var content:String!
    var smileNumber: NSNumber!
    var commentNumber: NSNumber!
    
    
    //初始化的时候完成解析
    init(dict:NSDictionary) {
        super.init()
        commentNumber = dict["comments_count"] as! NSNumber
        content = dict["content"] as! String
        let votesDic = dict["votes"] as! NSDictionary
        smileNumber = votesDic["up"] as! NSNumber
        
        if dict["user"] is NSDictionary {
            let userDic = dict["user"] as! NSDictionary
            //根据字典创建model
            configureUserWithDic(userDic)
        }
        else {
            //不存在 user 字典
            nickName = "匿名用户"
            iconUrl = nil
        }
    }
    //配置用户信息
    func configureUserWithDic(dict:NSDictionary) {
        //昵称
        nickName = dict["login"] as! String
        
        if dict["icon"] is String {
            let icon = dict["icon"] as! String
            //如果  id 是字符串类型
            if dict["id"] is NSString {
                let idStr = dict["id"] as! NSString
                let idString = idStr.substringToIndex(4)
                iconUrl = kPhotoUrl + "\(idString)/\(idStr)/medium/\(icon)"
            }
            else {
                //是 NSNumber类型
                let idNumber = dict["id"] as! NSNumber
                let idStr = "\(idNumber)" as NSString
                let idStr4 = idStr.substringToIndex(4)
                iconUrl = kPhotoUrl + "\(idStr4)/\(idStr)/medium/\(icon)"
                
            }
        }
            
        else {
            iconUrl = nil
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
