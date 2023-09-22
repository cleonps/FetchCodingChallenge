//
//  HTTPClient.swift
//  FetchCodingChallenge
//
//  Created by Christian León Pérez Serapio on 18/09/23.
//

import Foundation

protocol HTTPClient {
    func request(_ request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: HTTPClient {
    func request(_ request: URLRequest) async throws -> (Data, URLResponse) {
        try await URLSession.shared.data(for: request)
    }
}

