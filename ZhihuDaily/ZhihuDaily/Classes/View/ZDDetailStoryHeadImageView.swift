//
//  ZDDetailStoryHeadImageView.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/17.
//  Copyright © 2017年 Oneself. All rights reserved.
//

import Kingfisher

class ZDDetailStoryHeadImageView: UIView {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var imageSourceLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    private var colorLayer: CAGradientLayer?
    
    class func headImageView() -> ZDDetailStoryHeadImageView {
        
        let nib = UINib(nibName: "ZDDetailStoryHeadImageView", bundle: nil)
        
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! ZDDetailStoryHeadImageView
        
//        let colorLayer = CAGradientLayer()
//        colorLayer.startPoint = CGPoint(x: 1, y: 0)
//        colorLayer.endPoint = CGPoint(x: 1, y: 0.3)
//        colorLayer.colors = [UIColor.lightGray.cgColor, UIColor.clear.cgColor]
//        colorLayer.locations = [0.2]
//        view.layer.insertSublayer(colorLayer, above: view.backgroundImageView.layer)
//        colorLayer.frame = CGRect(x: 0, y: 0, width: 375, height: 100)
//        view.colorLayer = colorLayer
        
        return view
    }
    
    var detailStory: ZDDetailStory? {
        
        didSet {
            
            let url = URL(string: detailStory?.image ?? "")
            backgroundImageView.kf.setImage(with: ImageResource(downloadURL: url!))
            
            imageSourceLabel.text = "图片：\(detailStory?.image_source ?? "")"
            
            titleLabel.text = detailStory?.title
        }
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//    }
}
