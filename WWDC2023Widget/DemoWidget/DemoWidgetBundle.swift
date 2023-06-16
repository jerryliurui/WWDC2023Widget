//
//  DemoWidgetBundle.swift
//  DemoWidget
//
//  Created by JerryLiu on 2023/6/9.
//

import WidgetKit
import SwiftUI

@main
struct DemoWidgetBundle: WidgetBundle {
    var body: some Widget {
        DemoWidget()
        DemoWidgetLiveActivity()
    }
}
