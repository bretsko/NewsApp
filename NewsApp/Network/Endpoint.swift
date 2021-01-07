//
//  Endpoint.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 5/2/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

enum EndPoint: String {
    
    case articles
    case language
    case category
    
    case sources //endpoint for fetching array of sources
    case source // for fetching article using source
    
    case country
    case topHeadline
    // case comments(articleId: Int)
    
    static let baseURL = "https://newsapi.org/v2/"
    
    
    func makeURL(with params: [String : String]) -> URL {
        
        let strParams = paramsToString(parameters: params)
        let urlStr = Self.baseURL + "\(makePath())?\(strParams)"
        return URL(string: urlStr)!
    }
    
    func makeURLRequest(with params: [String : String],
                        apiKey: String) -> URLRequest {
        let url =  makeURL(with: params)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = makeHeaders(with: apiKey)
        request.httpMethod = "GET"
        return request
    }
    
    // ??
    // sources for category, and everything for articles search
    func makePath() -> String {
        switch self {
        case .category, .topHeadline, .country, .source:
            return "top-headlines"
        case .articles, .language:
            return "everything"
        case .sources:
            return rawValue
        }
    }
    
    func makeHeaders(with apiKey: String) -> [String: String] {
        [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "X-Api-Key \(apiKey)", // "Authorization"
            "Host": "newsapi.org"
        ]
    }
    
    /// create string from array of parameters joining each element with & and put "=" between key and value
    private func paramsToString(parameters: [String: String]) -> String {
        let params = makeParams(with: parameters).filter { !$0.value.isEmpty }.map { key, value in
            // create an array from key and value //filtering value that is empty or ""
            //        let parameterArray = parameters.map { key, value in //create an array from key and valuexb
            "\(key)=\(value)"
        }
        return params.joined(separator: "&")
        // join each element in array with &
    }
    
    // grab the parameters for the appropriate object (article or comment) and add default
    private func makeParams(with parameters: [String: String]) -> [String: String] {
        
        switch self {
        case .sources:
            // for list of sources
            return [
                // more info at https://newsapi.org/docs/endpoints/sources
                "category": parameters["category"] ?? "",
                
                // either: business, entertainment, general, health, science, sports, technology
                "language": parameters["language"] ?? "",
                
                // Find sources that display news in a specific language. Possible options: ar de en es fr he it nl no pt ru se ud zh . Default: all languages.
                
                "country": parameters["country"] ?? "",
                // Find sources that display news in a specific country. Possible options: ae ar at au be bg br ca ch cn co cu cz de eg fr gb gr hk hu id ie il in it jp kr lt lv ma mx my ng nl no nz ph pl pt ro rs ru sa se sg si sk th tr tw ua us ve za . Default: all countries.
            ]
            
        case .articles, .language:
            
            //everything has these parameters
            return [
                // more info at https://newsapi.org/docs/endpoints/everything
                "q": parameters["q"] ?? "",
                
                // Keywords or phrases to search for in the article title and body.
                "qInTitle": parameters["qInTitle"] ?? "",
                
                // Keywords or phrases to search for in the article title only.
                "sources": parameters["sources"] ?? "",
                
                // A comma-seperated string of identifiers (maximum 20) for the news sources or blogs you want headlines from. Use the /sources endpoint to locate these programmatically
                //                    "domains": parameters["domains"] ?? "", //A comma-seperated string of domains (eg bbc.co.uk, techcrunch.com, engadget.com) to restrict the search to.
                
                // "excludeDomains": parameters["excludeDomains"] ??  "" //A comma-seperated string of domains (eg bbc.co.uk, techcrunch.com, engadget.com) to remove from the results.
                "from": parameters["from"] ?? "\(makeISO8601DateByWeek(weekCount: -1))",
                
                // A date and optional time for the oldest article allowed. This should be in ISO 8601 format (e.g. 2020-04-25 or 2020-04-25T02:36:43) Default: the oldest according to your plan.
                "to": parameters["to"] ?? "",
                
                // A date and optional time for the newest article allowed. This should be in ISO 8601 format (e.g. 2020-04-25 or 2020-04-25T02:36:43) Default: the newest according to your plan.
                "language": parameters["language"] ?? "en",
                
                // The 2-letter ISO-639-1 code of the language you want to get headlines
                "sortBy": parameters["sortBy"] ?? "publishedAt",
                
                // values can only be relevancy, popularity, publishedAt
                "pageSize": parameters["pageSize"] ?? "20",
                
                // (Int) 20 default and 100 is max
                "page": parameters["page"] ?? "1",
                // (Int) Use this to page through the results.
            ]
            
        case .country, .topHeadline, .category:
            //top-headlines has these parameters
            
            return [
                "country": parameters["country"] ?? "us",
                // The 2-letter ISO 3166-1 code of the country you want to get headlines for. Possible options: ae ar at au be bg br ca ch cn co cu cz de eg fr gb gr hk hu id ie il in it jp kr lt lv ma mx my ng nl no nz ph pl pt ro rs ru sa se sg si sk th tr tw ua us ve za . Note: you can't mix this param with the sources param.
                
                "category": parameters["category"] ?? "general",
                // The category you want to get headlines for. Possible options: business entertainment general health science sports technology . Note: you can't mix this param with the sources param.
                //                "sources": parameters["sources"] ?? "", //A comma-seperated string of identifiers for the news sources or blogs you want headlines from. Use the /sources endpoint to locate these programmatically or look at the sources index. Note: you can't mix this param with the country or category params.
                //                "from": parameters["from"] ?? "\(makeISO8601DateByWeek(weekCount: -2))", //A date and optional time for the oldest article allowed. This should be in ISO 8601 format (e.g. 2020-04-25 or 2020-04-25T02:36:43) Default: the oldest according to your plan.
                
                "q": parameters["q"] ?? "",
                // Keywords or a phrase to search for.
                
                "pageSize": parameters["pageSize"] ?? "20",
                // The number of results to return per page (request). 20 is the default, 100 is the maximum.
                
                "page": parameters["page"] ?? "1",
                // Use this to page through the results if the total results found is greater than the page size.
            ]
        case .source:
            // source cannot have country or category endpoint
            return [
                "sources": parameters["sources"] ?? "",
                // A comma-seperated string of identifiers for the news sources or blogs you want headlines from. Use the /sources endpoint to locate these programmatically or look at the sources index. Note: you can't mix this param with the country or category params.
                
                "q": parameters["q"] ?? "",
                // Keywords or a phrase to search for.
                
                "pageSize": parameters["pageSize"] ?? "20",
                // The number of results to return per page (request). 20 is the default, 100 is the maximum.
                
                "page": parameters["page"] ?? "1",
                // Use this to page through the results if the total results found is greater than the page size.
            ]
        }
    }
}

enum EndPointError: Error {
    case couldNotParse(message: String)
    case noData(message: String)
    case unsupportedEndpoint(message: String)
    case endpointError(message: String)
    case maximumResultsReached(message: String = "You have reached maximum amount articles. Upgrade your account to see more.")
    case unknown(message: String = "Error status with no error message")
}

extension EndPointError: LocalizedError {
    
    // to show passed message for error.localizedDescription
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
