//
//  ZDTheme.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/10.
//  Copyright © 2017年 Oneself. All rights reserved.
//

class ZDTheme: ZDObject {
    
    var isHome: Bool = false
    
    var desc: String?
    
    var name: String?
    
    var id: NSInteger = 0
    
    var thumbnail: String?
    
    class func modelCustomPropertyMapper() -> [String: String] {
        return ["desc": "description"]
    }
}
