//
//  AppDelegate.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/7.
//  Copyright © 2017年 Oneself. All rights reserved.
//

import MMDrawerController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupUI()
        
        return true
    }
}

// MARK: - UI
extension AppDelegate {
    
    fileprivate func setupUI() {
        
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        
        let homeVC = ZDHomeViewController()
        let drawerController = MMDrawerController(center: ZDNavigationController(rootViewController: homeVC), leftDrawerViewController: ZDMenuViewController(), rightDrawerViewController: nil)
        drawerController?.openDrawerGestureModeMask = .all
        drawerController?.closeDrawerGestureModeMask = .all
        
        window?.rootViewController = drawerController
        window?.makeKeyAndVisible()
    }
}
