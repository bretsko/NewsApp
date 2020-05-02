//
//  Article.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/24/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

public struct ArticleList: Codable {
    public let status: String? //"ok" or error
    public let code: String? //code and message will have value if status is error
    public let message: String? //if status is error
    public let totalResults: Int? //if status is ok
    public let articles: [Article]?
}

public struct Source: Codable {
    public let id: String?
    public let name: String
}

/// A product retrieved from the Product Hunt API.
public struct Article {
    // Various properties of a post that we either need or want to display
    public let source: Source?
    public let author: String?
    public let title: String?
    public let description: String?
    public let publishedAt: String?
    public let content: String? //must be optional because some articles dont have content
    public let url: URL?
    public let urlToImage: URL?
    
//    func fetchImage(completion: @escaping (_ image: UIImage?, _ error: String?) -> Void) {
//        let request = URLRequest(url: previewImageURL)
//        let defaultSession = URLSession(configuration: .default)
//        let dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
//            guard error == nil else {
//                completion(nil, error?.localizedDescription)
//                return
//            }
//            guard let data = data else {
//                completion(nil, "No data")
//                return
//            }
//            DispatchQueue.main.async {
//                if let image = UIImage(data: data) {
//                    completion(image, nil)
//
//                } else {
//                    print("\(self.name) has no image fetched from \(self.previewImageURL)")
//                }
//            }
//        })
//        dataTask.resume()
//    }
}


// MARK: Codable
extension Article: Codable {}

extension Article: Equatable { //to be able to use .contains method or compare if they're equal
    public static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.title == rhs.title && lhs.url == rhs.url
    }
}

extension Article: Hashable { //Articles needs to conform to Hashable in order have unique elements when I turned them into a set or orderedSet
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.title.hashValue)
    }
}
