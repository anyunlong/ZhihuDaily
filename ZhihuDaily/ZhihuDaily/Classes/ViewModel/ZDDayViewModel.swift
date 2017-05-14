//
//  ZDDayViewModel.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/14.
//  Copyright © 2017年 Oneself. All rights reserved.
//

class ZDDayViewModel {
    
    var day: ZDDay
    
    var dateString: String
    
    init(day: ZDDay) {
        
        self.day = day
        
        // 1. 20170514 -> Date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let date = formatter.date(from: day.dateString ?? "") ?? Date()
        // 2. Date -> xx月xx日
        formatter.dateFormat = "MM月dd日"
        let formattedDateString = formatter.string(from: date)
        // 3. Date -> 星期x
        let weekdayString = date.weekday()
        
        dateString = "\(formattedDateString) \(weekdayString)"
    }
}
