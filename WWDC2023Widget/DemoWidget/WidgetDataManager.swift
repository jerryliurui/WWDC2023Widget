//
//  WidgetDataManager.swift
//  WWDC2023Widget
//
//  fetch Data
//
//  Created by JerryLiu on 2023/6/12.
//

import Foundation

class WidgetDataManager {
    static let shared = WidgetDataManager()
    
    //数据源 模拟
    var articles:[Article] = [
        .init(title: "一起来看看SwiftUI都有哪些新特性", likeNum: 100, imageName: "qwer",favor: false),
        .init(title: "五种实现SwftUI基础动画的方式", likeNum: 1086, imageName: "qwer",favor: false),
        .init(title: "提升生产力!Xcode使用快捷键推荐", likeNum: 4311, imageName: "qwer",favor: false)
    ]
    
    //模拟网络请求
    func requestAPI(urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "InvalidURL", code: -1, userInfo: nil)
        }
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        try await Task.sleep(nanoseconds: 2_000_000_000)//延迟两秒
        let (data, _) = try await session.data(for: request)
        
        return data
    }
}
