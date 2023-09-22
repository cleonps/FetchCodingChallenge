//
//  MealsMapper.swift
//  FetchCodingChallenge
//
//  Created by Christian León Pérez Serapio on 18/09/23.
//

import Foundation

struct MealsMapper {
    static func map(data: Data, response: URLResponse) throws -> [Meal] {
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw HTTPError.invalidServerResponse
        }
        guard let meals = try? JSONDecoder().decode(Meals.self, from: data).meals.sorted(by: { $0.strMeal < $1.strMeal } ) else {
            throw HTTPError.parseError
        }
        
        return meals
    }
}
