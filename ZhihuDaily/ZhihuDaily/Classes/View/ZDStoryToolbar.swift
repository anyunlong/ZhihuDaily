//
//  ZDStoryToolbar.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/15.
//  Copyright © 2017年 Oneself. All rights reserved.
//

class ZDStoryToolbar: UIToolbar {
    
    class func storyToolbar() -> ZDStoryToolbar {
        
        let nib = UINib(nibName: "ZDStoryToolbar", bundle: nil)
        
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! ZDStoryToolbar
        
        return view
    }
    
    @IBAction func clickReturnButton(_ sender: UIButton) {
        
        
    }
}
