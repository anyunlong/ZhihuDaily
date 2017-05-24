//
//  YLRefreshView.swift
//  YLRefreshControl
//
//  Created by Oneself on 17/2/24.
//  Copyright © 2017年 CCUT. All rights reserved.
//

import UIKit

private let YLRefreshTipIconAnimateDuration: Double = 0.25

enum YLRefreshState {
    case normal
    case pulling
    case willRefresh
}

class YLRefreshView: UIView {
    
    @IBOutlet weak var tipIcon: UIImageView!
    
    @IBOutlet weak var tipLabel: UILabel!

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    class func refreshView() -> YLRefreshView {
        
        let nib = UINib(nibName: "YLRefreshView", bundle: nil)
        
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! YLRefreshView
        
        return view
    }
    
    var refreshState: YLRefreshState = .normal {
        
        didSet {
            
            switch refreshState {
            case .normal:
                
                UIView.animate(withDuration: YLRefreshTipIconAnimateDuration) {
                    self.tipIcon.transform = CGAffineTransform.identity
                }
                tipIcon.isHidden = false
                indicator.stopAnimating()
                tipLabel.text = "载入上一篇"
            case .pulling:
                
                UIView.animate(withDuration: YLRefreshTipIconAnimateDuration) {
                    self.tipIcon.transform = CGAffineTransform(rotationAngle: CGFloat(.pi - 0.001))
                }
                tipLabel.text = "载入上一篇"
            case .willRefresh:
                
                tipIcon.isHidden = true
                indicator.startAnimating()
                tipLabel.text = nil
            }
        }
    }
}
