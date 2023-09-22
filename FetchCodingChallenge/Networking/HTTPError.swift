//
//  HTTPError.swift
//  FetchCodingChallenge
//
//  Created by Christian León Pérez Serapio on 18/09/23.
//

import Foundation

enum HTTPError: Error {
    case invalidURL
    case invalidServerResponse
    case parseError
}

extension HTTPError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidServerResponse: return "Invalid Server Response"
        case .parseError: return "Parse Error"
        }
    }
}
