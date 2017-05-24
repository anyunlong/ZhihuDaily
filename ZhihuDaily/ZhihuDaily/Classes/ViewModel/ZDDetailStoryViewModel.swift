//
//  ZDDetailStoryViewModel.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/16.
//  Copyright © 2017年 Oneself. All rights reserved.
//

class ZDDetailStoryViewModel {
    
    var storyIds: [String]?
    
    var currentStoryIndex = 0
    
    var isFirstStory = false
    
    lazy var detailStory = ZDDetailStory()
    
    var HTMLString: String?
    
    func loadDetailStory(loadDataMethod: ZDStoryLoadDataMethod, completion:@escaping (_ isSuccess: Bool) -> Void) {
        
        guard let storyIds = storyIds else {
            return
        }
        
        let storyId: String?
        switch loadDataMethod {
        case .dropDown:
            storyId = currentStoryIndex - 1 < 0 ? nil : storyIds[currentStoryIndex - 1]
        case .pull:
            storyId = currentStoryIndex + 1 > storyIds.count - 1 ? nil : storyIds[currentStoryIndex + 1]
        case .normal:
            storyId = storyIds[currentStoryIndex]
        }
        
        YLNetworkTool.detailStory(id: storyId ?? "") {
            guard let json = $0 else {
                completion(false)
                return
            }
            
            self.detailStory.yy_modelSet(withJSON: json)
            self.HTMLString = String(format: "<html><head><meta name='viewport' content='initial-scale=1.0, user-scalable=no' /><link type='text/css' rel='stylesheet' href='http://news-at.zhihu.com/css/news_qa.auto.css?v=4b3e3' ></link></head><body>%@</body></html>", self.detailStory.body ?? "")
            
            switch loadDataMethod {
            case .dropDown:
                self.currentStoryIndex -= 1
            case .pull:
                self.currentStoryIndex += 1
            case .normal:
                {}()
            }
            
            self.isFirstStory = self.currentStoryIndex == 0 ? true : false
            
            completion(true)
        }
    }
}
