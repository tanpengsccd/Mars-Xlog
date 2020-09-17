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
        XLogManager.shared.configXloggerWithPath(path: "/Log", filenamePrefix: "DEMO", publicKey: "", level: .debug, isConsoleLog: true)
        XLog.Log(level: .info, tag: .track, msg: "这是swift的打印")
        
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
