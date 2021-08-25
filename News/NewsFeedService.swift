//
//  NewsFeedService.swift
//  News
//
//  Created by Nicholas Angelo Petelo on 8/23/21.
//

import Foundation

enum ErrorTypes: Error {
    case badURLError
    case downloadError
    case decodingError
}

class NewsFeedService {
    
    private let headers = [
        "x-rapidapi-host": "webit-news-search.p.rapidapi.com",
        "x-rapidapi-key": "YOUR API KEY HERE"
    ]

    private let baseUrlString = "https://webit-news-search.p.rapidapi.com"
    
    public func getNewsFeed(offset: Int, completion: @escaping (Result<NewsFeedResponse, ErrorTypes>) -> Void) {
        
        let urlString = baseUrlString + "/trending?language=en&has_image=true&offset=\(offset)"
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            completion(.failure(ErrorTypes.badURLError))
            return }
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(ErrorTypes.downloadError))
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(NewsFeedResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()

    }
}
