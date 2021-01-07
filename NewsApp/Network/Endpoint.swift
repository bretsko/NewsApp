//
//  Endpoint.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 5/2/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

enum EndPoint {

    /// Search all articles
    /// https://newsapi.org/docs/endpoints/everything
    // Search through millions of articles from over 50,000 large and small news sources and blogs. This includes breaking news as well as lesser articles.
    case search(Set<FilterOption>)
    
    
    /// Search top headlines
    /// https://newsapi.org/docs/endpoints/top-headlines
    /// This endpoint provides live top and breaking headlines for a country, specific category in a country, single source, or multiple sources. You can also search with keywords. Articles are sorted by the earliest date published first.
    case top_headlines(Set<TopFilterOption>)
    
    
    /// get list of all news sources used to provide news
    /// https://newsapi.org/docs/endpoints/sources
    case sources

    
    static let baseURL = "newsapi.org"
  
 
    //MARK: -
    
    func makeURL(with apiKey: String,
                 pageParams: [URLQueryItem]? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = Self.baseURL
        components.path = getPath()
        
//        var queryItems = [
//            URLQueryItem(name: "apiKey", value: apiKey)
//        ]
        var queryItems = [URLQueryItem]()
        switch self {
        case .search(let filterOptionSet):
            queryItems = filterOptionSet.map{$0.queryItems}.flatMap{$0}
            
        case .top_headlines(let filterOptionSet):
            queryItems = filterOptionSet.map{$0.queryItem}
        
        case .sources:
            //TODO: category, country, language
            return components.url!
        }
        
        if let pageParams = pageParams {
             queryItems += pageParams
        } else {
            queryItems += NetworkManager.makeURLQueryItems()
        }
        components.queryItems = queryItems
        return components.url!
    }
    
    
    func makeURLRequest(with apiKey: String,
                        pageParams: [URLQueryItem]? = nil) -> URLRequest {
        let url = makeURL(with: apiKey, pageParams: pageParams)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = makeHeaders(with: apiKey)
        request.httpMethod = "GET" // all requests are Get
        return request
    }
    
    func getPath() -> String {
        switch self {
        case .search:
            return "/v2/everything"
        case .top_headlines:
            return "/v2/top-headlines"
        case .sources:
            return "/v2/sources"
        }
    }
    
    func makeHeaders(with apiKey: String? = nil) -> [String: String] {
        var r = [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Host": "newsapi.org"
        ]
        if let key = apiKey {
            r["Authorization"] = "X-Api-Key \(key)"
        }
        return r
    }
}

enum EndPointError: Error {
    case couldNotParse(message: String)
    case noData(message: String)
    case unsupportedEndpoint(message: String)
    case endpointError(message: String)
    case maximumResultsReached(message: String = "You have reached maximum amount articles(100). Upgrade your account to see more.")
    case unknown(message: String = "Unknown error")
}

extension EndPointError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case let .couldNotParse(message),
             let .noData(message),
             let .unsupportedEndpoint(message),
             let .endpointError(message),
             let .maximumResultsReached(message),
             let .unknown(message):
            return message
        }
    }
}

