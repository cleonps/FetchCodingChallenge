//
//  Request.swift
//  FetchCodingChallenge
//
//  Created by Christian León Pérez Serapio on 18/09/23.
//

import Foundation

enum Request {
    case getDesserts
    case getDessert(byId: String)
    
    private static let baseURL: String = "https://www.themealdb.com/api/json/v1/1/"
    
    var url: URL? {
        let path: String
        switch self {
        case .getDesserts:
            path = "filter.php?c=Dessert"
        case let .getDessert(id):
            path = "lookup.php?i=\(id)"
        }
        return URL(string: Request.baseURL + path)
    }
    
    var method: String { "GET" }
    
    func buildRequest() throws -> URLRequest {
        guard let url else { throw HTTPError.invalidURL }
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}
