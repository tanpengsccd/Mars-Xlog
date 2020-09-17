//
//  SwiftViewController.swift
//  MARSDK_Example
//
//  Created by 谭鹏 on 2020/9/17.
//  Copyright © 2020 wanghuizhou21@163.com. All rights reserved.
//

import UIKit
import MARSDK
class SwiftViewController: UIViewController {
    //MARK:- View
    
    
    //MARK:- 👀 Public Property 👀
    //MARK:- 📦 Private Property 📦
    //MARK:- 💤 Lazy Property  💤

    
    //MARK:- ♻️Life cycle♻️
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        //        self.hidesBottomBarWhenPushed = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.hidesBottomBarWhenPushed = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //Fix iOS10 CollectionView not call cellForRowAt
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        
        
        //默认配置
        XLogManager.shared.defaultConfig()
        /* 或者 定制配置
        XLogManager.shared.configXloggerWithPath(path: XLogManager.self.DefaultXlogDir, filenamePrefix: "XLOG", publicKey: "", level: .debug, isConsoleLog: true)
        */
        //打印
        XLog.Log(level: .info, tag: .track, msg: "这是swift的打印")
        //冲刷用于将缓存.map3文件转换为.xlog文件
        XLogManager.shared.flush_sync()
        //获取所有的日志路径
        let logs = XLogManager.shared.allNormalLogs
        for log in logs{
            print(log.absoluteString)
        }
        //关闭 一般是在app 终结是关闭
        // XLogManager.shared.close()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         navigationController?.setNavigationBarHidden(false, animated: animated)

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:- ⏹TableView DataSource⏹
    
    // MARK:- ⏹TableView Delegate⏹
    
    // MARK:- 👥Other Delegate 👥

    // MARK:- 👂Set Event Response👂
    private func setEventResponse(){

    }
    // MARK:- 👂Event Responce 👂
    
    // MARK:- 👀Public  Method👀

    // MARK:- 📦Private Method📦
    
    // MARK:- 🚀NET API🚀

}
