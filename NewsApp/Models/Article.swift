//
//  Article.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/24/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

struct ArticleList: Decodable {
    var status: String //"ok" or error
    var code: String? //code and message will have value if status is error
    var message: String? //if status is error
    var totalResults: Int? //if status is ok
    var articles: [Article]
}

/// A product retrieved from the Product Hunt API.
struct Article {
    // Various properties of a post that we either need or want to display
//    let source: object
    let author: String
    let title: String
    let description: String
    let publishedAt: String
    let content: String
    let url: URL
    let urlToImage: URL?
    
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


// MARK: Decodable
extension Article: Decodable {
    // properties within a Post returned from the Product Hunt API that we want to extract the info from.
    
    init(from decoder: Decoder) throws {
        // Decode the Post from the API call
        let articlesContainer = try decoder.container(keyedBy: ArticleKeys.self)
        // Decode each of the properties from the API into the appropriate type (string, etc.) for their associated struct variable
//        source = try articlesContainer.decode(String.self, forKey: .source)
        author = try articlesContainer.decode(String.self, forKey: .author)
        title = try articlesContainer.decode(String.self, forKey: .title)
        description = try articlesContainer.decode(String.self, forKey: .description)
        publishedAt = try articlesContainer.decode(String.self, forKey: .publishedAt)
        content = try articlesContainer.decode(String.self, forKey: .content)
        url = try articlesContainer.decode(URL.self, forKey: .url)
        urlToImage = try articlesContainer.decode(URL.self, forKey: .urlToImage)
//        let screenshotURLContainer = try postsContainer.nestedContainer(keyedBy: PreviewImageURLKeys.self, forKey: .previewImageURL) //new
//        // Decode the image and assign it to the variable
//        previewImageURL = try screenshotURLContainer.decode(URL.self, forKey: .imageURL) //new
    }
    
    enum ArticleKeys: String, CodingKey {
        case author, title, description, url, urlToImage, publishedAt, content
//        case makers = "makers" //no need to do this as API is in camelCase
    }
    
    enum SourceKeys: String, CodingKey {
        case id, name
    }
}


struct User: Codable {
//    let id: Int
    let name: String
    let imageURL: ImageURL

    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "image_url"
    }
}

// MARK: - ImageURL
struct ImageURL: Codable {
    let the50Px: String

    enum CodingKeys: String, CodingKey {
        case the50Px = "50px"
    }
}

struct Maker: Decodable {
    var name: String
//    var imageUrl: URL
    
    init(from decoder: Decoder) throws {
        // Decode the Post from the API call
        let makersContainer = try decoder.container(keyedBy: MakerKeys.self)
        // Decode each of the properties from the API into the appropriate type (string, etc.) for their associated struct variable
        name = try makersContainer.decode(String.self, forKey: .name)
//        let screenshotURLContainer = try makersContainer.nestedContainer(keyedBy: ImageURLKeys.self, forKey: .makerImageUrl) //new
        // Decode the image and assign it to the variable
//        imageUrl = try screenshotURLContainer.decode(URL.self, forKey: .imageURL) //new
    }
    
    enum MakerKeys: String, CodingKey {
        case name = ""
//        case makerImageUrl = "image_url"
    }
    
    enum ImageURLKeys: String, CodingKey {
        // for all posts, we only want the 850px image
        // Check out the screenshot_url property in our Postman call to see where this livesx
        case imageURL = "100px"
    }
}

