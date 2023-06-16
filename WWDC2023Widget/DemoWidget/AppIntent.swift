//
//  AppIntent.swift
//  DemoWidget
//
//  Created by JerryLiu on 2023/6/9.
//

import WidgetKit
import AppIntents

struct favorAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "articleId")
    var id: String
    
    init() {
        
    }
    
    //to hold data
    init(id: String) {
        self.id = id
    }
    
    func perform() async throws -> some IntentResult {
        if let index = WidgetDataManager.shared.articles.firstIndex(where: {
            $0.id == id
        }) {
            WidgetDataManager.shared.articles[index].favor.toggle()
        }
        
        return .result()
    }
}

struct likeAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "Like an article")
    var id: String
    
    init() {
        
    }
    
    init(id: String) {
        self.id = id
    }
    
    func perform() async throws -> some IntentResult {
        //模拟一个网络请求
        let _ = try await WidgetDataManager.shared.requestAPI(urlString: "https://catfact.ninja/fact")
        
        if let index = WidgetDataManager.shared.articles.firstIndex(where: {
            $0.id == id
        }) {
            WidgetDataManager.shared.articles[index].likeNum += 1
        }
        return .result()
    }
}
