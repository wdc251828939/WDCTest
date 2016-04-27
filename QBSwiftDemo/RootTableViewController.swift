//
//  RootTableViewController.swift
//  QBSwiftDemo
//
//  Created by lanouhn on 16/3/18.
//  Copyright © 2016年 王大超. All rights reserved.
//

import UIKit
var isDown = true

class RootTableViewController: UITableViewController, NetworkHelperDelegate {
    var page = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //自适应 label 高度
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 60
        
        //        设置代理
        NetworkHelper.helper.delegate = self
        //添加头部刷新控件
        //为了避免循环引用, weak 修饰
        weak var weakSelf = self
        
        self.tableView.addHeaderWithCallback { () -> Void in
            isDown = true
            weakSelf?.page = 1
            NetworkHelper.helper.catchDataAndAnalysisiWithUrl(URL: "http://m2.qiushibaike.com/article/list/text?count=30&page=\(weakSelf!.page)")
        }
        //添加尾部
        self.tableView.addFooterWithCallback { () -> Void in
            isDown = false
            weakSelf?.page++
            NetworkHelper.helper.catchDataAndAnalysisiWithUrl(URL: "http://m2.qiushibaike.com/article/list/text?count=30&page=\(weakSelf!.page)")
        }
        //进入界面自动刷新
        self.tableView.headerBeginRefreshing()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return NetworkHelper.helper.dataAray.count
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mycell", forIndexPath: indexPath) as! MyCell
        let model = NetworkHelper.helper.dataAray[indexPath.row] as! QBModel
        
        cell.configureCellWithModel(model)
        return cell
    }
   //协议方法
    func ReloadData() {
        //回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if isDown == true {
                //如果是下拉动作, 停止头部刷新
                self.tableView.headerEndRefreshing()
            } else {
                //如果是上提动作, 停止尾部刷新
                self.tableView.footerEndRefreshing()
            }
            //s刷新UI
            self.tableView.reloadData()
        }
    
    
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
