//
//  ZDStoryViewController.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/15.
//  Copyright © 2017年 Oneself. All rights reserved.
//

import WebKit

private let toolbarHeight: CGFloat = 45

class ZDStoryViewController: UIViewController {
    
    private lazy var detailStoryViewModel = ZDDetailStoryViewModel()
    
    var storyId: String?
    
    fileprivate lazy var storyToolbar: ZDStoryToolbar = ZDStoryToolbar.storyToolbar()
    
    fileprivate lazy var webView: WKWebView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setupUI()
        
        loadDetailStory()
    }
    
    private func loadDetailStory() {
        
        detailStoryViewModel.loadDetailStory(id: storyId ?? "") {
            if $0 == true {
                self.webView.loadHTMLString(self.detailStoryViewModel.HTMLString ?? "", baseURL: Bundle.main.bundleURL)
            }
        }
    }
}

// MARK: - UI
extension ZDStoryViewController {
    
    fileprivate func setupUI() {
        
        view.addSubview(storyToolbar)
        view.addSubview(webView)
        
        storyToolbar.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(toolbarHeight)
        }
        
        webView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(storyToolbar.snp.top)
        }
    }
}
