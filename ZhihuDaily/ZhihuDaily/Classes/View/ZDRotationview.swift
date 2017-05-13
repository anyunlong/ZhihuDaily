//
//  ZDRotationView.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/13.
//  Copyright © 2017年 Oneself. All rights reserved.
//

class ZDRotationView: UIScrollView {

    class func rotationView() -> ZDRotationView {
        
        let nib = UINib(nibName: "ZDRotationView", bundle: nil)
        
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! ZDRotationView
        
        view.bounds = CGRect(x: 0, y: 0, width: 0, height: 200)
        
        return view
    }
}
