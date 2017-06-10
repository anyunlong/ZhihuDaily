//
//  ZDDetailStoryHeadImageView.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/17.
//  Copyright © 2017年 Oneself. All rights reserved.
//

class ZDDetailStoryHeadImageView: UIView {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var imageSourceLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    class func headImageView() -> ZDDetailStoryHeadImageView {
        
        let nib = UINib(nibName: "ZDDetailStoryHeadImageView", bundle: nil)
        
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! ZDDetailStoryHeadImageView
        
        return view
    }
    
    var detailStory: ZDDetailStory? {
        
        didSet {
            
            guard let detailStory = detailStory else {
                return
            }
            
            backgroundImageView.setImage(url: detailStory.image ?? "")
            
            imageSourceLabel.text = "图片：\(detailStory.image_source ?? "")"
            
            titleLabel.text = detailStory.title
        }
    }
}
