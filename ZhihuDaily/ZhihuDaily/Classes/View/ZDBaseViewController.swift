//
//  ZDBaseViewController.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/13.
//  Copyright © 2017年 Oneself. All rights reserved.
//

class ZDBaseViewController: UIViewController {
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
