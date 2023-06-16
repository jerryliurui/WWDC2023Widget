//
//  DemoWidgetLiveActivity.swift
//  DemoWidget
//
//  Created by JerryLiu on 2023/6/9.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DemoWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct DemoWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DemoWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension DemoWidgetAttributes {
    fileprivate static var preview: DemoWidgetAttributes {
        DemoWidgetAttributes(name: "World")
    }
}

extension DemoWidgetAttributes.ContentState {
    fileprivate static var smiley: DemoWidgetAttributes.ContentState {
        DemoWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: DemoWidgetAttributes.ContentState {
         DemoWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: DemoWidgetAttributes.preview) {
   DemoWidgetLiveActivity()
} contentStates: {
    DemoWidgetAttributes.ContentState.smiley
    DemoWidgetAttributes.ContentState.starEyes
}
