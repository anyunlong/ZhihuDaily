//
//  ZDNavigationController.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/13.
//  Copyright © 2017年 Oneself. All rights reserved.
//

class ZDNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(popToHome), name: NSNotification.Name(rawValue: ZHShouldPopToHomeNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pushTheme), name: NSNotification.Name(rawValue: ZHShouldPushThemeNotification), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func popToHome() {
        popToRootViewController(animated: true)
    }
    
    @objc private func pushTheme() {
        pushViewController(ZDThemeViewController(), animated: true)
    }
}
