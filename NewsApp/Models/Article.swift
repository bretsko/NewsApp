//
//  Article.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/24/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

public struct ArticleList: Codable {
//    let requestStatus: String //"ok" or error
//    var code: String? //code and message will have value if status is error
//    var message: String? //if status is error
//    var totalResults: Int? //if status is ok
    public let articles: [Article]
    
//    enum CodingKeys: String, CodingKey {
//        case requestStatus = "status", articles
//    }
}

public struct Source: Codable {
    public let id: String?
    public let name: String
}

/// A product retrieved from the Product Hunt API.
public struct Article {
    // Various properties of a post that we either need or want to display
    public let source: Source
    public let author: String?
    public let title: String
    public let description: String?
    public let publishedAt: String
    public let content: String? //must be optional because some articles dont have content
    public let url: URL
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
