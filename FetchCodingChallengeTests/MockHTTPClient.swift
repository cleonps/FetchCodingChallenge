//
//  MockHTTPClient.swift
//  FetchCodingChallengeTests
//
//  Created by Christian León Pérez Serapio on 22/09/23.
//

@testable import FetchCodingChallenge
import Foundation

final class MockHTTPClient: HTTPClient {
    var failure: HTTPError?
    
    func request(_ request: URLRequest) async throws -> (Data, URLResponse) {
        guard failure == nil else { throw failure! }
        guard let url = request.url,
              let response: URLResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "", headerFields: [:]) else {
            throw HTTPError.invalidServerResponse
        }
        let data: Data
        switch url {
        case Request.getDesserts.url:
            data = getData(fromResource: "Desserts")
        case Request.getDessert(byId: "52893").url:
            data = getData(fromResource: "Dessert")
        default: throw HTTPError.invalidServerResponse
        }
        return (data, response)
    }
    
    private func getData(fromResource resource: String) -> Data {
        guard let path = Bundle(for: type(of: self)).path(forResource: resource, ofType: "json") else {
            fatalError("Desserts.json not found")
        }
        
        guard let jsonString = try? String(contentsOfFile: path, encoding: .utf8) else {
            fatalError("Unable to convert json to String")
        }
        
        guard let data = jsonString.data(using: .utf8) else {
            fatalError("Unable to convert json string to Data")
        }
        
        return data
    }
}
