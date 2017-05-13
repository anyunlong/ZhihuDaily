//
//  ZDThemesViewModel.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/10.
//  Copyright © 2017年 Oneself. All rights reserved.
//

class ZDThemesViewModel {
    
    lazy var themes: [ZDTheme] = {
        var themes = [ZDTheme]()
        
        let homeTheme = ZDTheme()
        homeTheme.isHome = true
        homeTheme.name = "首页"
        themes.append(homeTheme)
        
        return themes
    }()
    
    func loadThemes(completion:@escaping (_ isSuccess: Bool) -> Void) {
        
        YLNetworkTool.themes {
            
            guard let themesJSON = $0 else {
                completion(false)
                return
            }
            
            for themeJSON in themesJSON {
                let theme = ZDTheme()
                theme.yy_modelSet(withJSON: themeJSON.dictionaryObject ?? [:])
                self.themes.append(theme)
            }
            
            completion(true)
        }
    }
}
