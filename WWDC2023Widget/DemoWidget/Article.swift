//
//  Article.swift
//  WWDC2023Widget
//
//  Model for article
//
//  Created by JerryLiu on 2023/6/12.
//

import Foundation

struct Article: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var likeNum: Int
    var imageName: String
    var favor: Bool
}
