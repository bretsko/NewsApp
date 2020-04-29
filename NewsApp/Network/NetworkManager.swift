//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/24/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class NetworkManager {
    //make it singleton
    public static let shared = NetworkManager()
    private init() {}
    //properties
    static let urlSession = URLSession.shared // shared singleton session object used to run tasks. Will be useful later
    static let baseURL = "https://newsapi.org/v2/"
    static let apiKey = PrivateKeys.newsApiKey.rawValue
    static var parameters: [String: String] = [:]
    
///Function that calls fetchArticle or fetchSources depending on the endpoint
    static func fetchNewsApi(endpoint: EndPoints, parameters: [String: String] = [:], completion: @escaping (Result<[Article]>) -> Void) {
        for (key, value) in parameters where value != "" { //if value has value, then appen to self.parameters
            self.parameters[key] = value
        }
//        self.parameters = parameters
        switch endpoint {
        case .articles, .category, .country, .topHeadline: //these endpoints all receives an array of articles
            fetchArticles(endpoint: endpoint) { (result) in //fetch articles
                switch result {
                case let .success(articles):
                    completion(.success(articles))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        case .source: //get all sources, working but not implemented
            fetchSources { (result) in
                switch result {
                case let.success(sources):
                    print("Sources are: ", sources)
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        default:
            completion(.failure(EndPointError.unsupportedEndpoint(message: "Endpoint is not supported")))
        }
    }
    
///Wesley's fetch article
    static func getTopHeadLines(completion: @escaping (_ article: Article) -> ()){
        let url = URL(string: "\(NetworkManager.baseURL)top-headlines?country=us&apiKey=\(NetworkManager.apiKey)")
        let task = NetworkManager.urlSession.dataTask(with: url!, completionHandler: { data, response, error in
           if error != nil {
            print(error as Any)
                return
            }
            let articles = try? JSONDecoder().decode(ArticleList.self, from: data!)
            DispatchQueue.main.async {
                print("\(articles!)")
                print("DONE Printing articles")
            }
        })
        task.resume()
    }
    
///Use Endpoint.category for category VC with sources, and Endpoint.articles for list of articles with parameters
    static func fetchArticles(endpoint: EndPoints, completion: @escaping (Result<[Article]>) -> Void) {
        let articlesRequest = makeRequest(for: endpoint)
        let task = urlSession.dataTask(with: articlesRequest) { data, response, error in
            // Check for errors.
            if let error = error {
                return completion(Result.failure(error))
            }
            // Check to see if there is any data that was retrieved.
            guard let data = data else {
                return completion(Result.failure(EndPointError.noData(message: "Articles has no data")))
            }
            //decode data
            guard let result = try? JSONDecoder().decode(ArticleList.self, from: data) else {
                return completion(Result.failure(EndPointError.couldNotParse(message: "Could not parse Articles")))
            }
            if result.status == "error" { //check if status has error
//                do { //data debugging
//                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
//                    print(jsonResult)
//                } catch {
//                    print("Error deserializing JSON: \(error)")
//                }
                guard let errorMessage = result.message, let errorCode = result.code else { //check if theres an error message from the endpoint
                    return completion(Result.failure(EndPointError.unknown()))
                }
                switch errorCode { //check if endpoint error is known
                case "maximumResultsReached": //free acc allows to fetch 100 articles only
                    return completion(Result.failure(EndPointError.maximumResultsReached()))
                default:
                    return completion(Result.failure(EndPointError.endpointError(message: "Endpoint Error: \(errorMessage)")))
                }
            }
            DispatchQueue.main.async {
                //Ensure we are passing unique array articles. Article must conform to Hashable and Equatable
                let uniqueArticles = Array(NSOrderedSet(array: result.articles!)) as? [Article]
                completion(Result.success(uniqueArticles!))
            }
        }
        task.resume()
    }
    
    static func fetchSources(completion: @escaping (Result<[Source]>) -> Void) {
        let articlesRequest = makeRequest(for: .source) //setup request as source
        let task = urlSession.dataTask(with: articlesRequest) { data, response, error in
            // Check for errors.
            if let error = error {
                return completion(Result.failure(error))
            }
            // Check to see if there is any data that was retrieved.
            guard let data = data else {
                return completion(Result.failure(EndPointError.noData(message: "Sources has no data")))
            }
            guard let result = try? JSONDecoder().decode(Sources.self, from: data) else {
                return completion(Result.failure(EndPointError.couldNotParse(message: "Could not parse sources")))
            }
            let articles = result.sources
            // Return the result with the completion handler.
            DispatchQueue.main.async {
                completion(Result.success(articles))
            }
        }
        task.resume()
    }
    
    // All the code we did before but cleaned up into their own methods
    static private func makeRequest(for endPoint: EndPoints) -> URLRequest {
        // grab the parameters from the endpoint and convert them into a string
        let stringParams = endPoint.paramsToString()
        // get the path of the endpoint
        let path = endPoint.getPath()
        // create the full url from the above variables
        let fullURL = URL(string: baseURL.appending("\(path)?\(stringParams)"))!
        print("Full path: \(fullURL)")
        // build the request
        var request = URLRequest(url: fullURL)
        request.allHTTPHeaderFields = endPoint.getHeaders(apiKey: apiKey)
        request.httpMethod = endPoint.getHTTPMethod()
        return request
    }
    
    enum EndPoints {
        case articles
        case category
        case source
        case country
        case topHeadline
        case comments(articleId: Int)
        
        // determine which path to provide for the API request. sources for category, and everything for articles search
        func getPath() -> String {
            switch self {
            case .category, .topHeadline, .country:
                return "top-headlines"
            case .articles:
                return "everything"
            case .source:
                return "sources"
            case .comments:
                return "comments"
            }
        }
        
        // We're only ever calling GET for now, but this could be built out if that were to change
        func getHTTPMethod() -> String {
            return "GET"
        }
        
        // Same headers we used for Postman
        func getHeaders(apiKey: String) -> [String: String] {
            return [
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Authorization": "X-Api-Key \(apiKey)", //"Authorization"
                "Host": "newsapi.org"
            ]
        }
        
        // grab the parameters for the appropriate object (article or comment)
        func getParams() -> [String: String] {
            switch self {
            case .source:
                return [ //find more info at https://newsapi.org/docs/endpoints/sources
                    "category": NetworkManager.parameters["category"] ?? "business", //either: business, entertainment, general, health, science, sports, technology
                    "language": NetworkManager.parameters["language"] ?? "en", //Find sources that display news in a specific language. Possible options: ar de en es fr he it nl no pt ru se ud zh . Default: all languages.
                    "country": NetworkManager.parameters["country"] ?? "", //Find sources that display news in a specific country. Possible options: ae ar at au be bg br ca ch cn co cu cz de eg fr gb gr hk hu id ie il in it jp kr lt lv ma mx my ng nl no nz ph pl pt ro rs ru sa se sg si sk th tr tw ua us ve za . Default: all countries.
                ]
            case .articles:
                return [ //find more info at https://newsapi.org/docs/endpoints/everything
                    "q": NetworkManager.parameters["q"] ?? "", //Keywords or phrases to search for in the article title and body.
                    "qInTitle": "", //Keywords or phrases to search for in the article title only.
                    "sources": NetworkManager.parameters["sources"] ?? "", //A comma-seperated string of identifiers (maximum 20) for the news sources or blogs you want headlines from. Use the /sources endpoint to locate these programmatically
//                    "domains": NetworkManager.parameters["domains"] ?? "", //A comma-seperated string of domains (eg bbc.co.uk, techcrunch.com, engadget.com) to restrict the search to.
//                    "excludeDomains": NetworkManager.parameters["excludedDomains"] ??  "" //A comma-seperated string of domains (eg bbc.co.uk, techcrunch.com, engadget.com) to remove from the results.
                    "from": NetworkManager.parameters["from"] ?? "", //A date and optional time for the oldest article allowed. This should be in ISO 8601 format (e.g. 2020-04-25 or 2020-04-25T02:36:43) Default: the oldest according to your plan.
                    "to": NetworkManager.parameters["to"] ?? "", //A date and optional time for the newest article allowed. This should be in ISO 8601 format (e.g. 2020-04-25 or 2020-04-25T02:36:43) Default: the newest according to your plan.
                    "language": NetworkManager.parameters["language"] ??  "en", //The 2-letter ISO-639-1 code of the language you want to get headlines
                    "sortBy": NetworkManager.parameters["sortBy"] ?? "popularity", //values can only be relevancy, popularity, publishedAt
                    "pageSize": NetworkManager.parameters["pageSize"] ?? "20", //(Int) 20 default and 100 is max
//                    "page": NetworkManager.parameters["page"] ?? "20", //(Int) Use this to page through the results.
                ]
            case .country, .topHeadline, .category:
                return [
                    "country": NetworkManager.parameters["country"] ?? "us", //The 2-letter ISO 3166-1 code of the country you want to get headlines for. Possible options: ae ar at au be bg br ca ch cn co cu cz de eg fr gb gr hk hu id ie il in it jp kr lt lv ma mx my ng nl no nz ph pl pt ro rs ru sa se sg si sk th tr tw ua us ve za . Note: you can't mix this param with the sources param.
                    "category": NetworkManager.parameters["category"] ??  "business", //The category you want to get headlines for. Possible options: business entertainment general health science sports technology . Note: you can't mix this param with the sources param.
                    "sources": NetworkManager.parameters["sources"] ?? "", //A comma-seperated string of identifiers for the news sources or blogs you want headlines from. Use the /sources endpoint to locate these programmatically or look at the sources index. Note: you can't mix this param with the country or category params.
                    "q": NetworkManager.parameters["q"] ?? "", //Keywords or a phrase to search for.
                    "pageSize": NetworkManager.parameters["pageSize"] ??  "20", //The number of results to return per page (request). 20 is the default, 100 is the maximum.
                    "page": NetworkManager.parameters["page"] ?? "1", //Use this to page through the results if the total results found is greater than the page size.
                ]
            case let .comments(articleId):
                return [
                    "sort_by": "votes",
                    "order": "asc",
                    "per_page": "20",
                    "search[article_id]": "\(articleId)"
                ]
            }
        }
        
        ///create string from array of parameters joining each element with & and put "=" between key and value
        func paramsToString() -> String {
            let parameterArray = getParams().map { key, value in //create an array from key and value
                return "\(key)=\(value)"
            }
            return parameterArray.joined(separator: "&") //join each element in array with &
        }
    }
}

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum EndPointError: Error {
    case couldNotParse(message: String)
    case noData(message: String)
    case unsupportedEndpoint(message: String)
    case endpointError(message: String)
    case maximumResultsReached(message: String = "You have reached maximum amount articles. Upgrade your account to see more.")
    case unknown(message: String = "Error status with no error message")
}

extension EndPointError: LocalizedError { //to show passed message for error.localizedDescription
    public var errorDescription: String? {
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
