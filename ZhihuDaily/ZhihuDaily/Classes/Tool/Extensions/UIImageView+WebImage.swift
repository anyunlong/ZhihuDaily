//
//  UIImageView+WebImage.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/6/2.
//  Copyright © 2017年 Oneself. All rights reserved.
//

import Kingfisher

extension UIImageView {
    
    func setImage(url: String?, placeholder: UIImage? = nil) {
        
        var imageResource: ImageResource? = nil
        
        if let url = URL(string: url ?? "") {
            
            imageResource = ImageResource(downloadURL: url)
        }
        
        kf.setImage(with: imageResource, placeholder: placeholder)
    }
}
