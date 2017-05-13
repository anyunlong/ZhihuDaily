//
//  ZDHomeViewController.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/10.
//  Copyright © 2017年 Oneself. All rights reserved.
//

class ZDHomeViewController: ZDBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "home"

        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue: ZHHomePageShouldLoadDataNotification), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func loadData() {
        debugPrint("home load data ...")
    }
}
