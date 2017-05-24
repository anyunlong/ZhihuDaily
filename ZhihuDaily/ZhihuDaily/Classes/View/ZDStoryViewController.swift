//
//  ZDStoryViewController.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/15.
//  Copyright © 2017年 Oneself. All rights reserved.
//

import WebKit

private let toolbarHeight: CGFloat = 45

enum ZDStoryLoadDataMethod {
    case dropDown
    case pull
    case normal
}

class ZDStoryViewController: UIViewController {
    
    lazy var detailStoryViewModel = ZDDetailStoryViewModel()
    
    fileprivate lazy var storyToolbar = ZDStoryToolbar.storyToolbar()
    
    fileprivate lazy var webView = WKWebView()
    
    fileprivate lazy var headImageView = ZDDetailStoryHeadImageView.headImageView()
    
    fileprivate lazy var dropDownRefreshControl = YLRefreshControl()
    
    private var loadDataMethod: ZDStoryLoadDataMethod = .normal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setupUI()
        
        loadDetailStory()
    }
    
    @objc fileprivate func dropDownReloadData() {
        loadDataMethod = .dropDown
        loadDetailStory()
    }
    
    private func loadDetailStory() {
        
        detailStoryViewModel.loadDetailStory(loadDataMethod: loadDataMethod) {
            
            if $0 == true {
                
                self.detailStoryViewModel.isFirstStory ? print("是第一个") : print("不是第一个")
                
                self.webView.loadHTMLString(self.detailStoryViewModel.HTMLString ?? "", baseURL: Bundle.main.bundleURL)
                self.headImageView.detailStory = self.detailStoryViewModel.detailStory
            }
            
            self.dropDownRefreshControl.endRefreshing()
            self.loadDataMethod = .normal
        }
    }
}

// MARK: - UI
extension ZDStoryViewController {
    
    fileprivate func setupUI() {
        
        view.addSubview(storyToolbar)
        storyToolbar.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(toolbarHeight)
        }
        storyToolbar.returnButtonClosure = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(storyToolbar.snp.top)
        }
        
        let webContentView = webView.scrollView.subviews[0]
        webContentView.addSubview(headImageView)
        headImageView.snp.makeConstraints {
            $0.bottom.equalTo(webContentView.snp.top).offset(200)
            $0.left.equalTo(webContentView)
            // 貌似无效，宽度变得很窄
//            $0.right.equalTo(webContentView)
            // 无奈之举...
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.top.equalTo(webView)
        }
        
        webView.scrollView.delegate = self
        
        webView.scrollView.addSubview(dropDownRefreshControl)
        dropDownRefreshControl.addTarget(self, action: #selector(dropDownReloadData), for: .valueChanged)
    }
}

extension ZDStoryViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if -scrollView.contentOffset.y > 90 {
            scrollView.setContentOffset(CGPoint(x: 0, y: -90), animated: false)
        }
    }
}
