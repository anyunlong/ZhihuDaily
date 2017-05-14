//
//  ZDStorySectionHeaderView.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/14.
//  Copyright © 2017年 Oneself. All rights reserved.
//

class ZDStorySectionHeaderView: UITableViewHeaderFooterView {
    
    private lazy var dateStringLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.app
        return label
    }()
    
    var dateString: String? {
        
        didSet {
            
            dateStringLabel.text = dateString
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubview(dateStringLabel)
        
        dateStringLabel.snp.makeConstraints {
            
            $0.top.left.bottom.right.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
