//
//  ZDStoriesViewModel.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/13.
//  Copyright © 2017年 Oneself. All rights reserved.
//

class ZDStoriesViewModel {
    
    lazy var dayViewModels = [ZDDayViewModel]()
    
    lazy var storyIds = [String]()
    
    func loadStories(completion:@escaping (_ isSuccess: Bool) -> Void) {
        
        YLNetworkTool.stories(dateString: dayViewModels.last?.day.dateString) {
            
            guard let dateString = $0, let storiesJSON = $1 else {
                completion(false)
                return
            }
            
            let day = ZDDay()
            
            day.dateString = dateString
            
            for storyJSON in storiesJSON {
                
                let story = ZDStory()
                story.yy_modelSet(with: storyJSON.dictionaryObject ?? [:])
                story.image = storyJSON["images"][0].stringValue
                
                day.stories.append(story)
                
                self.storyIds.append(story.id ?? "")
            }
            
            let dayViewModel = ZDDayViewModel(day: day)
            
            self.dayViewModels.append(dayViewModel)
            
            completion(true)
        }
    }
}
