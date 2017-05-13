//
//  ZDNewsCell.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/13.
//  Copyright © 2017年 Oneself. All rights reserved.
//

import Kingfisher

class ZDNewsCell: UITableViewCell {
    
    @IBOutlet weak var titleTextView: UITextView!

    @IBOutlet weak var iconImageView: UIImageView!
    
    var story: ZDStory? {
        
        didSet {
            
            titleTextView.text = story?.title
            
            let url = URL(string: story?.image ?? "")
            iconImageView.kf.setImage(with: ImageResource(downloadURL: url!))
        }
    }
}
