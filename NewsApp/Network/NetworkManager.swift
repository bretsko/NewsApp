//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/24/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    //MARK: -
    
    // shared singleton session object used to run tasks. Will be useful later
    private let urlSession = URLSession.shared
    
    private let apiKey = "f7971dc8dd764567b33544a9daf7fcae"
    
    //TODO: move to VC or even ViewModel, first refactor to MVVM
    var numArticlesOnBackend = 0
    
    
    //MARK: - fetch
    
    //??
    /// Use Endpoint.category for category VC with sources, and Endpoint.articles for list of articles with parameters
    func fetchArticles(_ endpoint: EndPoint,
                       pageParams: [URLQueryItem]? = nil,
                       completion: @escaping (Result<[Article]>) -> ()) {

        let pageParams1: [URLQueryItem]
        if let params = pageParams {
            pageParams1 = params
        } else {
            pageParams1 = NetworkManager.makeURLQueryItems()
        }
        let request = endpoint.makeURLRequest(with: apiKey, pageParams: pageParams1)
        print("Sending request to: \(request.url!)")
        
        let task = urlSession.dataTask(with: request) { data, _, error in
            if let error = error {
                return completion(.failure(error))
            }
            guard let data = data else {
                return completion(.failure(EndPointError.noData(message: "Articles has no data")))
            }
            guard let result = try? JSONDecoder().decode(ArticleList.self, from: data) else {
                
                //FIXME: wrong error, can be no sources, not parsing error
                return completion(.failure(EndPointError.couldNotParse(message: "Could not parse Articles")))
            }
            
            guard let status = result.status else {
                return completion(.failure(EndPointError.couldNotParse(message: result.message ?? EndPointError.unknown())))
            }
            guard status != "error" else {
                guard let errorMessage = result.message,
                      let errorCode = result.code else {
                    return completion(.failure(EndPointError.unknown()))
                }
                switch errorCode {
                case "maximumResultsReached":
                    return completion(.failure(EndPointError.maximumResultsReached()))
                default:
                    return completion(.failure(EndPointError.endpointError(message: "Endpoint Error \(errorCode): \(errorMessage)")))
                }
                return
            }
            self.numArticlesOnBackend = result.totalResults!
            completion(.success(result.articles!))
        }
        task.resume()
    }
    
    //TODO:
    // add filter options - category, country, language
    // see https://newsapi.org/docs/endpoints/sources
    func fetchAllSources(completion: @escaping (Result<[Source]>) -> ()) {
        
        let request = EndPoint.sources.makeURLRequest(with: apiKey)
        print("Sending request to: \(request.url!)")

        let task = urlSession.dataTask(with: request) { data, _, error in
            if let error = error {
                return completion(.failure(error))
            }
            guard let data = data else {
                return completion(.failure(EndPointError.noData(message: "Sources has no data")))
            }
            
            //FIXME: wrong error, can be no sources, not parsing error
            guard let result = try? JSONDecoder().decode(Sources.self, from: data) else {
                return completion(.failure(EndPointError.couldNotParse(message: "Could not parse sources")))
            }
            
            if result.status != "ok" {
                completion(.failure(EndPointError.endpointError(message: result.message ?? "Unknown endpoint error")))
            } else {
                let sources = result.sources
                completion(.success(sources))
            }
        }
        task.resume()
    }
    
    static func makeURLQueryItems(page: Int = 1, 
                                  pageSize: Int = 20) -> [URLQueryItem] {
        [
            URLQueryItem(name: "page",
                         value: String(page)),
            URLQueryItem(name: "pageSize",
                         value: String(pageSize))
        ]
    }
}

enum Result<T> {
    case success(T)
    case failure(Error)
}
