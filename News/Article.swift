//
//  Article.swift
//  News
//
//  Created by Nicholas Angelo Petelo on 8/23/21.
//

import Foundation

struct NewsFeedResponse: Codable {
    let data: NewsFeedData
}

struct NewsFeedData: Codable {
    let results: [Article]
}

struct Article: Codable {
    let id: String
    let url: String
    let date: String
    let source_name: String
    let title: String
    let description: String
    let author: String
    let image: String?
}


