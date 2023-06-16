//
//  Item.swift
//  WWDC2023Widget
//
//  Created by JerryLiu on 2023/6/9.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
