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
        
        navigationBar.isHidden = true
        
        view.backgroundColor = UIColor.white
        
        addFullScreenReturnGes()
        
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

// MARK: - 全屏手势
extension ZDNavigationController: UIGestureRecognizerDelegate {
    
    fileprivate func addFullScreenReturnGes() {
        
        let target = interactivePopGestureRecognizer?.delegate
        let handler = NSSelectorFromString("handleNavigationTransition:")
        
        let fullScreenGes = UIPanGestureRecognizer(target: target, action: handler)
        fullScreenGes.delegate = self
        view.addGestureRecognizer(fullScreenGes)
        
        interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return childViewControllers.count == 1 ? false : true
    }
}
