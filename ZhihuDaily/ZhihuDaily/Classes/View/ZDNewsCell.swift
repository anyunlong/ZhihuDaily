//
//  ZDNewsCell.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/13.
//  Copyright © 2017年 Oneself. All rights reserved.
//

class ZDNewsCell: UITableViewCell {
    
    @IBOutlet weak var titleTextView: UITextView!

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var multipicImageView: UIImageView!
    
    var story: ZDStory? {
        
        didSet {
            
            guard let story = story else {
                return
            }
            
            titleTextView.text = story.title
            
            iconImageView.setImage(url: story.image ?? "", placeholder: #imageLiteral(resourceName: "Image_Preview"))
            
            multipicImageView.isHidden = story.multipic ? false : true
        }
    }
}
