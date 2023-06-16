//
//  WWDC2023WidgetApp.swift
//  WWDC2023Widget
//
//  Created by JerryLiu on 2023/6/9.
//

import SwiftUI
import SwiftData

@main
struct WWDC2023WidgetApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
