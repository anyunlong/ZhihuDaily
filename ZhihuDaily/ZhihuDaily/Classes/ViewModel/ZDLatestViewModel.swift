//
//  ZDLatestViewModel.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/13.
//  Copyright © 2017年 Oneself. All rights reserved.
//

class ZDLatestViewModel {
    
    lazy var stories = [ZDStory]()
    
    func loadLatest(completion: @escaping (_ isSuccess: Bool) -> Void) {
        
        YLNetworkTool.latest {
            
            guard let storiesJSON = $0 else {
                completion(false)
                return
            }
            
            for storeJSON in storiesJSON {
                
                let store = ZDStory()
                store.yy_modelSet(with: storeJSON.dictionaryObject ?? [:])
                store.image = storeJSON["images"][0].stringValue
                self.stories.append(store)
            }
            
            completion(true)
        }
    }
}
