//
//  ViewController.swift
//  memo camera
//
//  Created by kanata kana on 2015/09/05.
//  Copyright (c) 2015年 かなたす. All rights reserved.
//



import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var textField :UITextField?
    var filePaths:NSArray? = nil
    var tableView:UITableView? = nil
    var listToRemove:Bool = false
    
    /// ファイルの保存先
    let directoryPath = NSHomeDirectory().stringByAppendingPathComponent("Documents")
    
    
    let alert_title   = ""
    let alert_message = "ファイル名を入力してください"
    let alert_done    = "完了"
    let alert_cancel  = "キャンセル"
    
    let message_succeed = "ファイルの作成に成功しました"
    let message_failure = "ファイルの作成に失敗しました"
    
    let message_no_filename = "ファイル名がありません"
    
    let placeholder = "ファイル名"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initPaths()
    }
    
    /// 画面の生成
    func initView() {
        if listToRemove {
            self.title = "ファイルを削除"
        } else {
            self.title = "ファイル一覧"
        }
        
        let frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        
        tableView = UITableView(frame: frame)
        tableView?.delegate   = self
        tableView?.dataSource = self
        
        self.view.addSubview(tableView!)
        self.navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "showAlertToCreateFile")
    }
    
    
    
    
    
    // MARK: - Init
    
    
    /// ファイル一覧を取得する
    func initPaths() {
        let fileManager = NSFileManager.defaultManager()
        
        filePaths = fileManager.contentsOfDirectoryAtPath(directoryPath, error: nil)
        
        // ファイル一覧を更新する
        tableView!.reloadData()
    }
    
    
    /// テーブルセルの行を取得
    func getTextForCell(row:Int) -> String {
        let fileName = filePaths!.objectAtIndex(row) as! String
        
        return String(format: "ファイル名：%@", fileName)
    }
    
    
    
    // MARK: - Get Text
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell =
        UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = getTextForCell(indexPath.row)
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (filePaths != nil) {
            return filePaths!.count
        } else {
            return 0
        }
    }
    
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row == 0 {
            //  showFileList()
        }
        else if indexPath.row == 0 {
            showAlertToCreateFile()
        }
        else {
            // showFileListToRemove()
        }
    }
    
    // MARK: - Show FileListViewController
    
    // MARK: - Show AlertController
    
    /// ファイル名を受け取ってファイルを作成する
    func createFile(fileName:String?) {
        if fileName != nil {
            let fileManager = NSFileManager()
            
            let filePath = directoryPath.stringByAppendingPathComponent(fileName!)
            
            NSLog("createFile %@", filePath)
            
            let fileData = fileName!.dataUsingEncoding(NSUTF8StringEncoding)
            
            if fileManager.createFileAtPath(filePath, contents: fileData, attributes: nil) {
                showAlertMessage("", message: message_succeed)
            } else {
                showAlertMessage("", message: message_failure)
            }
        } else {
            showAlertMessage("", message: message_no_filename)
        }
    }
    
    // MARK: - Show AlertController
    
    /// ファイルを作成するためにUIAlertControllerを表示する
    func showAlertToCreateFile() {
        let alertController =
        UIAlertController(title: alert_title, message: alert_message, preferredStyle:.Alert)
        
        // OKを押したときはファイルを保存する
        let otherAction = UIAlertAction(title: alert_done, style: .Default) { Void in
            self.createFile(self.textField?.text)
        }
        
        // キャンセルを押したときは何もしない
        let cancelAction = UIAlertAction(title: alert_cancel, style: .Cancel) { Void in }
        
        alertController.addTextFieldWithConfigurationHandler { textField in
            self.textField = textField
            self.textField!.placeholder = self.placeholder
        }
        
        alertController.addAction(otherAction)
        alertController.addAction(cancelAction)
        
        /// 選択したファイルを削除する
        func removeFile(row:Int) {
            let fileName = filePaths?.objectAtIndex(row) as! String
            
            let filePath = directoryPath.stringByAppendingPathComponent(fileName)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    /// メッセージを表示するためにUIAlertControllerを表示する
    func showAlertMessage(title:String, message:String) {
        let alertController =
        UIAlertController(title: title, message: message, preferredStyle:.Alert)
        
        let otherAction = UIAlertAction(title: alert_done, style: .Default) { Void in }
        
        alertController.addAction(otherAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}


