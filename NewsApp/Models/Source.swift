//
//  Source.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/25/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

struct Sources: Decodable {
    var status: String
    var sources: [Source]
}

//struct Source: Decodable {
//    var id: String //identifier of news source
//    var name: String //name news source
//    var description: String //A description of the news source
//    var url: URL //URL of the homepage.
//    var category: String //type of news
//    var language: String //language news was written on
//    var country: String //country this news source is based in (and primarily writes about)
//}
