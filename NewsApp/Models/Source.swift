//
//  Source.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/25/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

struct Sources: Codable {
    var status: String
    var sources: [Source]
    var message: String? //in case status is not ok
}

public struct ArticleSource: Codable {
    public let id: String?
    public let name: String
}

public struct Source: Codable {
    var id: String //identifier of news source
    var name: String //name news source
    var description: String //A description of the news source
    var url: URL //URL of the homepage.
    var category: String //type of news
    var language: String //language news was written on
    var country: String //country this news source is based in (and primarily writes about)
}
