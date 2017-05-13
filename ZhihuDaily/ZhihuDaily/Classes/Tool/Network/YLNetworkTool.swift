//
//  YLNetworkTool.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/10.
//  Copyright © 2017年 Oneself. All rights reserved.
//

import Alamofire

class YLNetworkTool {
    
    class func request(URLString: String,
                 completion:@escaping (_ json: Any?) -> Void) {
        
        Alamofire.request(URLString).responseJSON {
            guard let json = $0.result.value else {
                completion(nil)
                return
            }
            
            completion(json)
        }
    }
}
