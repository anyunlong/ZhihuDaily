//
//  ZDScrollView.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/29.
//  Copyright © 2017年 Oneself. All rights reserved.
//

import UIKit

class ZDScrollView: UIScrollView {
    override var contentSize: CGSize {
        didSet {
            contentOffset = CGPoint(x: width, y: 0)
        }
    }
}
