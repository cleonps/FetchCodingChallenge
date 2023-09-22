//
//  MealsService.swift
//  FetchCodingChallenge
//
//  Created by Christian León Pérez Serapio on 18/09/23.
//

import Foundation

protocol MealsServiceProtocol {
    func fetchDesserts() async throws -> [Meal]
    func fetchDessert(byId id: String) async throws -> Meal
}

final class MealsService: MealsServiceProtocol {
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient = URLSession.shared) {
        self.httpClient = httpClient
    }
    
    func fetchDesserts() async throws -> [Meal] {
        let request = try Request.getDesserts.buildRequest()
        let (data, response) = try await httpClient.request(request)
        return try MealsMapper.map(data: data, response: response)
    }
    
    func fetchDessert(byId id: String) async throws -> Meal {
        let request = try Request.getDessert(byId: id).buildRequest()
        let (data, response) = try await httpClient.request(request)
        return try MealMapper.map(data:data, response: response)
    }
}
