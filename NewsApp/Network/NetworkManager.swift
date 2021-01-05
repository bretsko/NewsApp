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
    
    private static let defaultParameters = ["page": "0",
                                            "pageSize": "20"]
    private var parameters = NetworkManager.defaultParameters
    
    //TODO: move to VC or even ViewModel, first refactor to MVVM
    var numArticlesOnBackend = 0
    
    
    //MARK: -
    
    func updateParameters(parameters: [String: String]) {
        
        for parameter in parameters.compactMapValues({ $0 }) where parameter.value != "" { 
            self.parameters[parameter.key] = parameter.value
        }
    }
    
    /// reset numArticlesOnBackend and parameters
    func resetNetworkManager() {
        numArticlesOnBackend = 0
        parameters = Self.defaultParameters
    }
    
   
    //MARK: - fetch

    
    // ?? Function that calls fetchArticle or fetchSources depending on the endpoint
    func fetchNews(_ endpoint: EndPoint,
                   parameters: [String: String] = [:],
                   completion: @escaping (Result<[Article]>) -> ()) {
        updateParameters(parameters: parameters)
        switch endpoint {
        case .articles, .category, .country, .topHeadline, .source, .language:
            // these endpoints all receives an array of articles
            fetchArticles(endpoint) { result in
                switch result {
                case let .success(articles):
                    completion(.success(articles))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        default:
            completion(.failure(EndPointError.unsupportedEndpoint(message: "Endpoint is not supported")))
        }
    }
    
    //??
    /// Use Endpoint.category for category VC with sources, and Endpoint.articles for list of articles with parameters
    func fetchArticles(_ endpoint: EndPoint,
                       completion: @escaping (Result<[Article]>) -> ()) {
        
        let articlesRequest = endpoint.makeURLRequest(with: parameters, apiKey: apiKey)
        let task = urlSession.dataTask(with: articlesRequest) { data, _, error in
            if let error = error {
                return completion(Result.failure(error))
            }
            guard let data = data else {
                return completion(Result.failure(EndPointError.noData(message: "Articles has no data")))
            }
            guard let result = try? JSONDecoder().decode(ArticleList.self, from: data) else {
                //                do { //data debugging
                //                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
                //                    print(jsonResult)
                //                } catch {
                //                    print("Error deserializing JSON: \(error)")
                //                }
                
                //FIXME: wrong error, can be no sources, not parsing error
                return completion(Result.failure(EndPointError.couldNotParse(message: "Could not parse Articles")))
            }
            if result.status == "error" {
                guard let errorMessage = result.message, let errorCode = result.code else { // check if theres an error message from the endpoint
                    return completion(Result.failure(EndPointError.unknown()))
                }
                switch errorCode { // check if endpoint error is known
                case "maximumResultsReached":
                    // free acc allows to fetch 100 articles only
                    return completion(Result.failure(EndPointError.maximumResultsReached()))
                default:
                    return completion(Result.failure(EndPointError.endpointError(message: "Endpoint Error \(errorCode): \(errorMessage)"))) // error message from endpoint
                }
            }
            self.numArticlesOnBackend = result.totalResults!
            
            //??
            // Ensure we are passing unique array articles
            let uniqueArticles = Array(NSOrderedSet(array: result.articles!)) as? [Article]
            completion(Result.success(uniqueArticles!))
        }
        task.resume()
    }
    
    func fetchSources(completion: @escaping (Result<[Source]>) -> ()) {
        
        let articlesRequest = makeRequest(for: .sources)
        let task = urlSession.dataTask(with: articlesRequest) { data, _, error in
            if let error = error {
                return completion(Result.failure(error))
            }
            guard let data = data else {
                return completion(Result.failure(EndPointError.noData(message: "Sources has no data")))
            }
            
            //FIXME: wrong error, can be no sources, not parsing error
            guard let result = try? JSONDecoder().decode(Sources.self, from: data) else {
                return completion(Result.failure(EndPointError.couldNotParse(message: "Could not parse sources")))
            }
            if result.status != "ok" {
                completion(Result.failure(EndPointError.endpointError(message: result.message ?? "Unknown endpoint error")))
            }
            let sources = result.sources
            completion(Result.success(sources))
        }
        task.resume()
    }
    
    //TODO: improve request making using
    // https://stackoverflow.com/questions/57963583/swift-get-request-with-url-parameters
    
    /// All the code we did before but cleaned up into their own methods
    private func makeRequest(for endPoint: EndPoint) -> URLRequest {
        endPoint.makeURLRequest(with: parameters, apiKey: apiKey)
    }
}

enum Result<T> {
    case success(T)
    case failure(Error)
}
