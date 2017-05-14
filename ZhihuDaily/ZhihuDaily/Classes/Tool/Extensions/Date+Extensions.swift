//
//  Date+Extensions.swift
//
//  Created by Oneself on 2017/5/14.
//  Copyright © 2017年 Oneself. All rights reserved.
//

import Foundation

extension Date {
    
    func weekday() -> String {
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.weekday], from: self)
        
        let weekday = components.weekday ?? 0
        
        switch weekday {
            
        case 1:
            return "星期日"
        case 2:
            return "星期一"
        case 3:
            return "星期二"
        case 4:
            return "星期三"
        case 5:
            return "星期四"
        case 6:
            return "星期五"
        case 7:
            return "星期六"
        default:
            return ""
        }
    }
}
