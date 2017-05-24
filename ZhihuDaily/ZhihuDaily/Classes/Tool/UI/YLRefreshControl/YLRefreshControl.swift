//
//  YLRefreshControl.swift
//  YLRefreshControl
//
//  Created by Oneself on 17/2/23.
//  Copyright © 2017年 CCUT. All rights reserved.
//

import UIKit

private let YLRefreshOffset: CGFloat = 60

class YLRefreshControl: UIControl {
    
    private weak var scrollView: UIScrollView?
    
    fileprivate lazy var refreshView: YLRefreshView = YLRefreshView.refreshView()
    
    init() {
        super.init(frame: CGRect())
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        guard let superview = superview as? UIScrollView else {
            return
        }
        
        scrollView = superview
        
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
        
        frame = CGRect(x: 0, y: 0, width: superview.bounds.size.width, height: 0)
    }
    
    override func removeFromSuperview() {
        
        superview?.removeObserver(self, forKeyPath: "contentOffset")
        
        super.removeFromSuperview()
    }
    
    func beginRefreshing() {
        
        guard let scrollView = scrollView else {
            return
        }
        
        if refreshView.refreshState == .willRefresh {
            return
        }
        
        /// 设置状态
        refreshView.refreshState = .willRefresh
        
        /// 设置下拉间距
        var contentInsert = scrollView.contentInset
        contentInsert.top += YLRefreshOffset
        
        scrollView.contentInset = contentInsert
        
        sendActions(for: [.valueChanged])
    }

    func endRefreshing() {
        
        guard let scrollView = scrollView else {
            return
        }
        
        if refreshView.refreshState != .willRefresh {
            return
        }
        
        /// 设置状态
        refreshView.refreshState = .normal
        
        /// 设置下拉间距
        var contentInsert = scrollView.contentInset
        contentInsert.top -= YLRefreshOffset
        
        scrollView.contentInset = contentInsert
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let scrollView = scrollView else {
            return
        }
        
        let height = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        
        if height < 0 {
            return
        }
        
        frame = CGRect(x: 0, y: -height, width: scrollView.bounds.width, height: height)
        
        let refreshState = refreshView.refreshState
        
        if scrollView.isDragging {
            if height > YLRefreshOffset && refreshState == .normal {
                refreshView.refreshState = .pulling
            } else if height < YLRefreshOffset && refreshState == .pulling{
                refreshView.refreshState = .normal
            }
        } else {
            if refreshState == .pulling {
                beginRefreshing()
            }
        }
    }
}

extension YLRefreshControl {
    
    fileprivate func setupUI() {
        
        addSubview(refreshView)
        
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))

        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: refreshView.bounds.width))
        
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .height,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: refreshView.bounds.height))
    }
}
