//
//  ZDHeadImageView.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/26.
//  Copyright © 2017年 Oneself. All rights reserved.
//

import UIKit

class ZDHeadImageView: UIView {
    
    fileprivate var currentPage = 0
    
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var leftlabel: UILabel!
    
    @IBOutlet weak var centerImageView: UIImageView!
    @IBOutlet weak var centerLabel: UILabel!
    
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var rightLabel: UILabel!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var topStories: [ZDStory] = [ZDStory]() {
        
        didSet {
            
            let centerStory = topStories[(currentPage + topStories.count) % topStories.count]
            centerLabel.text = centerStory.title
            centerImageView.setImage(url: centerStory.image)
            
            let leftStory = getLeftStory(currentPage: currentPage)
            leftlabel.text = leftStory.title
            leftImageView.setImage(url: leftStory.image)
            
            let rightStory = getRightStory(currentPage: currentPage)
            rightLabel.text = rightStory.title
            rightImageView.setImage(url: rightStory.image)
            
            pageControl.numberOfPages = topStories.count
        }
    }
    
    @IBOutlet weak var scrollView: ZDScrollView!
    
    @IBOutlet weak var stackView: UIStackView!

    class func headImageView() -> ZDHeadImageView {
        
        let nib = UINib(nibName: "ZDHeadImageView", bundle: nil)
        
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! ZDHeadImageView
        
        view.bounds = CGRect(x: 0, y: 0, width: 0, height: 200)
        
        return view
    }
    
    fileprivate func leftPage(currentPage: Int) -> Int {
        return (currentPage - 1 + topStories.count) % topStories.count
    }
    
    fileprivate func rightPage(currentPage: Int) -> Int {
        return (currentPage + 1 + topStories.count) % topStories.count
    }
    
    fileprivate func getLeftStory(currentPage: Int) -> ZDStory {
        return topStories[leftPage(currentPage: currentPage)]
    }
    
    fileprivate func getRightStory(currentPage: Int) -> ZDStory {
        return topStories[rightPage(currentPage: currentPage)]
    }
}

extension ZDHeadImageView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x > scrollView.width {
            
            let currentStory = getRightStory(currentPage: currentPage)
            centerLabel.text = currentStory.title
            centerImageView.setImage(url: currentStory.image)
            
            currentPage = rightPage(currentPage: currentPage)
        } else if scrollView.contentOffset.x < scrollView.width {
            
            let currentStory = getLeftStory(currentPage: currentPage)
            centerLabel.text = currentStory.title
            centerImageView.setImage(url: currentStory.image)
            
            currentPage = leftPage(currentPage: currentPage)
        } else {
            
        }
        
        scrollView.setContentOffset(CGPoint(x: scrollView.width, y: 0), animated: false)
        
        let leftStory = getLeftStory(currentPage: currentPage)
        leftlabel.text = leftStory.title
        leftImageView.setImage(url: leftStory.image)
        
        let rightStory = getRightStory(currentPage: currentPage)
        rightLabel.text = rightStory.title
        rightImageView.setImage(url: rightStory.image)
        
        pageControl.currentPage = currentPage
    }
}
