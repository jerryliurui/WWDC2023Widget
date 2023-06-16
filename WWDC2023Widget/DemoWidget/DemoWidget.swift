//
//  DemoWidget.swift
//  DemoWidget
//
//  Created by JerryLiu on 2023/6/9.
//

import WidgetKit
import SwiftUI
import AppIntents

struct ArticlesEntry: TimelineEntry {
    let date: Date
    var readCount: Int
    //let configuration: ConfigurationAppIntent
    var lastArticles: [Article]
}

#Preview(as: .systemMedium) {
    DemoWidget()
} timeline: {
    ArticlesEntry(date: .now, readCount: 198, lastArticles: Array(WidgetDataManager.shared.articles.prefix(3)))
    ArticlesEntry(date: .now, readCount: 284, lastArticles: Array(WidgetDataManager.shared.articles.prefix(3)))
    ArticlesEntry(date: .now, readCount: 398, lastArticles: Array(WidgetDataManager.shared.articles.prefix(3)))
}

struct Provider: TimelineProvider {
    func getSnapshot(in context: Context, completion: @escaping (ArticlesEntry) -> Void) {
        completion(ArticlesEntry(date: Date(), readCount: 100, lastArticles: Array(WidgetDataManager.shared.articles.prefix(3))))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ArticlesEntry>) -> Void) {
        var entries: [ArticlesEntry] = []
        let entry = ArticlesEntry(date: .now, readCount: 100, lastArticles: Array(WidgetDataManager.shared.articles.prefix(3)))
        entries.append(entry)
        //此处模拟一个entry to end
        completion(Timeline(entries: [entry], policy: .atEnd))
    }
    
    func placeholder(in context: Context) -> ArticlesEntry {
        ArticlesEntry(date: Date(), readCount: 100, lastArticles: Array(WidgetDataManager.shared.articles.prefix(3)))
    }
}

struct DemoWidgetEntryView : View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var family
    
    var body: some View {
        switch family {
        case .systemSmall:
            widgetDemoSmallBGView(entry: entry)
            //widgetDemoSmallBGView
            //widgetDemoSmallMarginsView
            //widgetDemoSmallStandByView
        case .systemMedium:
            widgetDemoMediaView(entry: entry)
        default:
            widgetDemoSmallBGView(entry: entry)
        }
    }
}

//SmallView 验证边距的变化
struct widgetDemoSmallMarginsView: View {
    
    //环境变量找到当前的边距
    @Environment(\.widgetContentMargins) var margin
    
    let entry: Provider.Entry
    var body: some View {
        ZStack {
            Color.yellow.ignoresSafeArea()//ignoresSafeArea never work
        }
        .containerBackground(for: .widget) {
            Color.blue
        }
        .padding(margin)
    }
}

//SmallView 背景图片的变化
struct widgetDemoSmallBGView: View {
    let entry: Provider.Entry
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea() //❎
            Image("IMG_3843")
                .resizable()
                 .frame(width: 40,height: 40)
            
            Spacer()
        }
        .containerBackground(for: .widget) {
            Color.clear
        }
    }
}

//SmallView StandBy
struct widgetDemoSmallStandByView: View {
    @Environment(\.showsWidgetContainerBackground) var showCBG
    
    //观察到环境中的渲染模式，来根据这个来相对应的渲染我们的View
    @Environment(\.widgetRenderingMode) var reneringMode
    
    
    let entry: Provider.Entry
    var body: some View {
        VStack(alignment: .leading) {
            Text("北京")
                .font(.footnote)
            Text("35°")
                .font(showCBG ? .footnote: .largeTitle)//toshow more important View
            Text("☀️")
                .font(.subheadline)
            Text("周六")
                .font(.subheadline)
        }
        .containerBackground(for: .widget) {
            Color.blue
        }
    }
}

//mediumView
struct widgetDemoMediaView: View {
    let entry: Provider.Entry
    var body: some View {
        VStack(alignment: .leading, spacing: 5.0) {
            HStack {
                TotalReadView(readCount: entry.readCount)
            }
        
            VStack(alignment: .leading, spacing:6) {
                ForEach(entry.lastArticles.sorted {
                    !$0.favor && $1.favor
                }) { article in
                    HStack(alignment: .center, spacing:4.0) {
                        VStack {
                            Text(article.title)
                                .textScale(.secondary)
                                .lineLimit(1)
                        }
                        
                        Spacer(minLength: 0)
                        
                        Text(article.likeNum.formatted())
                            .contentTransition(.numericText())
                            .invalidatableContent()
                            .id(article.id)

                        //点赞button
                        Button(intent: likeAppIntent(id: article.id)) {
                            Image(systemName: "hand.thumbsup")
                                .foregroundColor(.yellow)
                        }
                        .buttonStyle(.plain)
                        
                        //收藏button
                        Button(intent: favorAppIntent(id: article.id)) {
                            Image(systemName: article.favor ? "heart.fill" : "heart")
                                .foregroundColor(.blue)
                        }
                        .buttonStyle(.plain)
                    }
                    
                    Spacer(minLength: 6)
                }
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .containerBackground(for: .widget, alignment: .topLeading) {
            //Image("swiftdata-96x96")
            Color.white
        }
    }
}

//今日阅读量
struct TotalReadView: View {
    let readCount: Int
    
    var body: some View {
        HStack() {
            Text("今日阅读")
                .id(readCount)
                //.transition(.push(from: .leading))
            
            Text(readCount.formatted())
                //.contentTransition(.numericText())
                //.animation(.smooth(duration: 0.2),value: readCount)
        }
        .font(.headline)
        .fontDesign(.rounded)
    }
}

//主Widget 配置
struct DemoWidget: Widget {
    let kind: String = "DemoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DemoWidgetEntryView(entry: entry)
        }
        //.contentMarginsDisabled()
        //.containerBackgroundRemovable(false)
    }
}

/**
 视频顺序
 1.视频主要内容，简要总结
 2.先看demo 效果
 3.1 new Xcode preview
 3.2 content animation and so on
 4.1 create article model and data manager fetch api (add delay)
 4.2 create widget timeline and entry view
 4.3 create app intent
 4.4 create button
 5.1 widgetDemoSmallBGView
 5.2 widgetDemoSmallMarginsView
 5.3 widgetDemoSmallStandByView
 */
