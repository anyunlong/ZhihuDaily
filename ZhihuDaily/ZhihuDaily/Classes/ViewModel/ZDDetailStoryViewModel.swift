//
//  ZDDetailStoryViewModel.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/16.
//  Copyright © 2017年 Oneself. All rights reserved.
//

class ZDDetailStoryViewModel {
    
    lazy var detailStory = ZDDetailStory()
    
    var HTMLString: String?
    
    func loadDetailStory(id: String, completion:@escaping (_ isSuccess: Bool) -> Void) {
        
        YLNetworkTool.detailStory(id: id) {
            guard let json = $0 else {
                completion(false)
                return
            }
            
            self.detailStory.yy_modelSet(withJSON: json)
            self.HTMLString = String(format: "<html><head><meta name='viewport' content='initial-scale=1.0, user-scalable=no' /><link type='text/css' rel='stylesheet' href='http://news-at.zhihu.com/css/news_qa.auto.css?v=4b3e3' ></link></head><body>%@</body></html>", self.detailStory.body ?? "")
            
            completion(true)
        }
    }
}
