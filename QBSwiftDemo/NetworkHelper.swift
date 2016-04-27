//
//  NetworkHelper.swift
//  QBSwiftDemo
//
//  Created by lanouhn on 16/3/18.
//  Copyright © 2016年 王大超. All rights reserved.
//

import UIKit
//协议
protocol NetworkHelperDelegate:NSObjectProtocol {
    func ReloadData()
}
class NetworkHelper: NSObject {
    //单例
    static let helper = NetworkHelper()
    //设置数据源属性
    var dataAray = NSMutableArray()
    
    //设置代理属性
    var delegate : NetworkHelperDelegate!
    
    //向服务器发送请求
    
    func catchDataAndAnalysisiWithUrl(URL urlString : String) {
        let url = NSURL(string: urlString)!
        
        //创建请求对象
        
        let URLrequest = NSURLRequest(URL: url)
        
        
        //创建任务
        
        let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(URLrequest) { (data : NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            if error == nil {
                if isDown == true {
                    //下拉刷新, 清空数据源
                    self.dataAray.removeAllObjects()
                    
                }
                //解析数据源
                let Dic = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                
                let itemArray = Dic["items"] as! NSArray
                //遍历数组
                for aDict in itemArray {
                    
                    let modelDic = aDict as! NSDictionary
                    //通过构造的初始化方法构造模型
                    let model = QBModel(dict: modelDic)
                    
                    
                    self.dataAray.addObject(model)
                }
//                刷新UI(代理传值)
                if self.delegate != nil && self.delegate.respondsToSelector(Selector("ReloadData")) {
                    self.delegate.ReloadData()
                }
            }
        }
        //开始任务
        dataTask.resume()
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
