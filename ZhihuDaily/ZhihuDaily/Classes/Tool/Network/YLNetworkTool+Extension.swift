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
                completion(nil)
                return
            }
            completion(themesJSON)
        }
    }
    
    class func stories(dateString: String? = nil, completion: @escaping (_ dateString: String?, _ stories: [JSON]?, _ topStories: [JSON]?) -> Void) {
        
        var routing = "latest"
        if let dateString = dateString {
            routing = "before/\(dateString)"
        }
        
        YLNetworkTool.request(URLString: "http://news-at.zhihu.com/api/4/news/\(routing)") {
            
            guard let jsonObject = $0 else {
                completion(nil, nil, nil)
                return
            }
            
            let json = JSON(jsonObject)
            let dateString = json["date"].stringValue
            guard let storiesJSON = json["stories"].array else {
                completion(nil, nil, nil)
                return
            }
            
            guard let topStoriesJSON = json["top_stories"].array else {
                completion(dateString, storiesJSON, nil)
                return
            }
            completion(dateString, storiesJSON, topStoriesJSON)
        }
    }
    
    class func detailStory(id: String, completion:@escaping (_ story: Any?) -> Void) {
        
        YLNetworkTool.request(URLString: "http://news-at.zhihu.com/api/4/news/\(id)") {
            
            guard let jsonObject = $0 else {
                completion(nil)
                return
            }
            
            completion(jsonObject)
        }
    }
}
