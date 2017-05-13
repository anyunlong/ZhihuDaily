//
//  YLNetworkTool+Extension.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/10.
//  Copyright © 2017年 Oneself. All rights reserved.
//

import SwiftyJSON

extension YLNetworkTool {
    
    class func themes(completion:@escaping (_ themes: [JSON]?) -> Void) {
        
        YLNetworkTool.request(URLString: "http://news-at.zhihu.com/api/4/themes") {
            
            guard let jsonObject = $0 else {
                completion(nil)
                return
            }
            
            let json = JSON(jsonObject)
            guard let themesJSON = json["others"].array else {
                return
            }
            completion(themesJSON)
        }
    }
    
    class func latest(completion:@escaping (_ stories: [JSON]?) -> Void) {
        
        YLNetworkTool.request(URLString: "http://news-at.zhihu.com/api/4/news/latest") {
            
            guard let jsonObject = $0 else {
                completion(nil)
                return
            }
            
            let json = JSON(jsonObject)
            guard let storiesJSON = json["stories"].array else {
                return
            }
            completion(storiesJSON)
        }
    }
}
