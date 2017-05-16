//
//  ZDThemeViewController.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/10.
//  Copyright © 2017年 Oneself. All rights reserved.
//

class ZDThemeViewController: ZDBaseViewController {
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = UIColor.green
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "theme"
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(rawValue: ZHThemePageShouldReloadDataNotification), object: nil)
    }
    
    @objc private func reloadData() {
        debugPrint("theme reload data ...")
    }
}

// MARK: - UI
extension ZDThemeViewController {
    
    override func setupUI() {
        
    }
}
