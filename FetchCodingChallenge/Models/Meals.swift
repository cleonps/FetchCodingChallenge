//
//  Meals.swift
//  FetchCodingChallenge
//
//  Created by Christian León Pérez Serapio on 18/09/23.
//

struct Meals: Codable {
    let meals: [Meal]
}

struct Meal: Codable {
    // General Properties
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    
    // Detail Properties
    var strInstructions: String? = nil
    var strIngredient1: String? = nil
    var strIngredient2: String? = nil
    var strIngredient3: String? = nil
    var strIngredient4: String? = nil
    var strIngredient5: String? = nil
    var strIngredient6: String? = nil
    var strIngredient7: String? = nil
    var strIngredient8: String? = nil
    var strIngredient9: String? = nil
    var strIngredient10: String? = nil
    var strIngredient11: String? = nil
    var strIngredient12: String? = nil
    var strIngredient13: String? = nil
    var strIngredient14: String? = nil
    var strIngredient15: String? = nil
    var strIngredient16: String? = nil
    var strIngredient17: String? = nil
    var strIngredient18: String? = nil
    var strIngredient19: String? = nil
    var strIngredient20: String? = nil
    var strMeasure1: String? = nil
    var strMeasure2: String? = nil
    var strMeasure3: String? = nil
    var strMeasure4: String? = nil
    var strMeasure5: String? = nil
    var strMeasure6: String? = nil
    var strMeasure7: String? = nil
    var strMeasure8: String? = nil
    var strMeasure9: String? = nil
    var strMeasure10: String? = nil
    var strMeasure11: String? = nil
    var strMeasure12: String? = nil
    var strMeasure13: String? = nil
    var strMeasure14: String? = nil
    var strMeasure15: String? = nil
    var strMeasure16: String? = nil
    var strMeasure17: String? = nil
    var strMeasure18: String? = nil
    var strMeasure19: String? = nil
    var strMeasure20: String? = nil
}

extension Meal {
    init(strMeal: String, strMealThumb: String, idMeal: String) {
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.idMeal = idMeal
    }
}

extension Meal {
    func getIngredientsWithMeasure() -> String {
        let ingredients = getIngredients()
        let measures = getMeasures()
        var arrayResult = [String]()
        ingredients.enumerated().forEach { index, ingredient in
            let measure: String
            if let safeMeasure = measures[safe: index] {
                measure = " \(safeMeasure)"
            } else {
                measure = ""
            }
            arrayResult.append("\t- \(ingredient)\(measure)")
        }
        let result = arrayResult.joined(separator: "\n")
        return result
    }
    
    private func getIngredients() -> [String] {
        var ingredients = [String?]()
        ingredients.append(strIngredient1)
        ingredients.append(strIngredient2)
        ingredients.append(strIngredient3)
        ingredients.append(strIngredient4)
        ingredients.append(strIngredient5)
        ingredients.append(strIngredient6)
        ingredients.append(strIngredient7)
        ingredients.append(strIngredient8)
        ingredients.append(strIngredient9)
        ingredients.append(strIngredient10)
        ingredients.append(strIngredient11)
        ingredients.append(strIngredient12)
        ingredients.append(strIngredient13)
        ingredients.append(strIngredient14)
        ingredients.append(strIngredient15)
        ingredients.append(strIngredient16)
        ingredients.append(strIngredient17)
        ingredients.append(strIngredient18)
        ingredients.append(strIngredient19)
        ingredients.append(strIngredient20)
        return ingredients.compactMap { $0 }.filter { !$0.isEmpty }
    }
    
    private func getMeasures() -> [String] {
        var measures = [String?]()
        measures.append(strMeasure1)
        measures.append(strMeasure2)
        measures.append(strMeasure3)
        measures.append(strMeasure4)
        measures.append(strMeasure5)
        measures.append(strMeasure6)
        measures.append(strMeasure7)
        measures.append(strMeasure8)
        measures.append(strMeasure9)
        measures.append(strMeasure10)
        measures.append(strMeasure11)
        measures.append(strMeasure12)
        measures.append(strMeasure13)
        measures.append(strMeasure14)
        measures.append(strMeasure15)
        measures.append(strMeasure16)
        measures.append(strMeasure17)
        measures.append(strMeasure18)
        measures.append(strMeasure19)
        measures.append(strMeasure20)
        return measures.compactMap { $0 }.filter { !$0.isEmpty }
    }
}

extension Meal: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.strMeal == rhs.strMeal &&
        lhs.strMealThumb == rhs.strMealThumb &&
        lhs.idMeal == rhs.idMeal &&
        lhs.strInstructions == rhs.strInstructions &&
        lhs.strIngredient1 == rhs.strIngredient1 &&
        lhs.strIngredient2 == rhs.strIngredient2 &&
        lhs.strIngredient3 == rhs.strIngredient3 &&
        lhs.strIngredient4 == rhs.strIngredient4 &&
        lhs.strIngredient5 == rhs.strIngredient5 &&
        lhs.strIngredient6 == rhs.strIngredient6 &&
        lhs.strIngredient7 == rhs.strIngredient7 &&
        lhs.strIngredient8 == rhs.strIngredient8 &&
        lhs.strIngredient9 == rhs.strIngredient9 &&
        lhs.strIngredient10 == rhs.strIngredient10 &&
        lhs.strIngredient11 == rhs.strIngredient11 &&
        lhs.strIngredient12 == rhs.strIngredient12 &&
        lhs.strIngredient13 == rhs.strIngredient13 &&
        lhs.strIngredient14 == rhs.strIngredient14 &&
        lhs.strIngredient15 == rhs.strIngredient15 &&
        lhs.strIngredient16 == rhs.strIngredient16 &&
        lhs.strIngredient17 == rhs.strIngredient17 &&
        lhs.strIngredient18 == rhs.strIngredient18 &&
        lhs.strIngredient19 == rhs.strIngredient19 &&
        lhs.strIngredient20 == rhs.strIngredient20 &&
        lhs.strMeasure1 == rhs.strMeasure1 &&
        lhs.strMeasure2 == rhs.strMeasure2 &&
        lhs.strMeasure3 == rhs.strMeasure3 &&
        lhs.strMeasure4 == rhs.strMeasure4 &&
        lhs.strMeasure5 == rhs.strMeasure5 &&
        lhs.strMeasure6 == rhs.strMeasure6 &&
        lhs.strMeasure7 == rhs.strMeasure7 &&
        lhs.strMeasure8 == rhs.strMeasure8 &&
        lhs.strMeasure9 == rhs.strMeasure9 &&
        lhs.strMeasure10 == rhs.strMeasure10 &&
        lhs.strMeasure11 == rhs.strMeasure11 &&
        lhs.strMeasure12 == rhs.strMeasure12 &&
        lhs.strMeasure13 == rhs.strMeasure13 &&
        lhs.strMeasure14 == rhs.strMeasure14 &&
        lhs.strMeasure15 == rhs.strMeasure15 &&
        lhs.strMeasure16 == rhs.strMeasure16 &&
        lhs.strMeasure17 == rhs.strMeasure17 &&
        lhs.strMeasure18 == rhs.strMeasure18 &&
        lhs.strMeasure19 == rhs.strMeasure19 &&
        lhs.strMeasure20 == rhs.strMeasure20
    }
}
