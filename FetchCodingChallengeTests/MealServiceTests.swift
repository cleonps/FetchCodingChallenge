//
//  MealServiceTests.swift
//  FetchCodingChallengeTests
//
//  Created by Christian León Pérez Serapio on 18/09/23.
//

import XCTest
@testable import FetchCodingChallenge

final class MealServiceTests: XCTestCase {
    var sut: MealsService!
    var httpClient: MockHTTPClient!
    
    override func setUp() {
        let httpClient = MockHTTPClient()
        let sut = MealsService(httpClient: httpClient)
        self.sut = sut
        self.httpClient = httpClient
    }
    
    override func tearDown() {
        sut = nil
        httpClient = nil
    }
    
    func test_sut_init() throws {
        _ = try XCTUnwrap(sut, "SUT should be set")
        _ = try XCTUnwrap(httpClient, "httpClient should be set")
    }
}

// MARK: - FETCH DESSERTS
extension MealServiceTests {
    func test_fetchDesserts_success() async throws {
        let expectedDesserts = [
            Meal(strMeal: "Apam balik", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", idMeal: "53049"),
            Meal(strMeal: "Apple & Blackberry Crumble", strMealThumb: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg", idMeal: "52893")
        ]
        let desserts = try await sut.fetchDesserts()
        XCTAssertEqual(desserts, expectedDesserts)
    }
    
    func test_fetchDesserts_failsWithInvalidServerResponse() async throws {
        httpClient.failure = .invalidServerResponse
        var catchedError: HTTPError?
        do {
            let _ = try await sut.fetchDesserts()
            XCTFail("Fetching should fail")
        } catch {
            catchedError = error as? HTTPError
        }
        
        XCTAssertEqual(catchedError, HTTPError.invalidServerResponse)
    }
    
    func test_fetchDesserts_failsWithParseError() async throws {
        httpClient.failure = .parseError
        var catchedError: HTTPError?
        do {
            let _ = try await sut.fetchDesserts()
            XCTFail("Fetching should fail")
        } catch {
            catchedError = error as? HTTPError
        }
        
        XCTAssertEqual(catchedError, HTTPError.parseError)
    }
    
    func test_fetchDesserts_failsWithInvalidURL() async throws {
        httpClient.failure = .invalidURL
        var catchedError: HTTPError?
        do {
            let _ = try await sut.fetchDesserts()
            XCTFail("Fetching should fail")
        } catch {
            catchedError = error as? HTTPError
        }
        
        XCTAssertEqual(catchedError, HTTPError.invalidURL)
    }
}

// MARK: - FETCH DESSERT BY ID
extension MealServiceTests {
    func test_fetchDessertById_success() async throws {
        let expectedDessert = Meal(strMeal: "Apple & Blackberry Crumble",
                                   strMealThumb: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg",
                                   idMeal: "52893",
                                   strInstructions: "Heat oven to 190C/170C fan/gas 5. Tip the flour and sugar into a large bowl. Add the butter, then rub into the flour using your fingertips to make a light breadcrumb texture. Do not overwork it or the crumble will become heavy. Sprinkle the mixture evenly over a baking sheet and bake for 15 mins or until lightly coloured.\r\nMeanwhile, for the compote, peel, core and cut the apples into 2cm dice. Put the butter and sugar in a medium saucepan and melt together over a medium heat. Cook for 3 mins until the mixture turns to a light caramel. Stir in the apples and cook for 3 mins. Add the blackberries and cinnamon, and cook for 3 mins more. Cover, remove from the heat, then leave for 2-3 mins to continue cooking in the warmth of the pan.\r\nTo serve, spoon the warm fruit into an ovenproof gratin dish, top with the crumble mix, then reheat in the oven for 5-10 mins. Serve with vanilla ice cream.",
                                   strIngredient1: "Plain Flour",
                                   strIngredient2: "Caster Sugar",
                                   strIngredient3: "Butter",
                                   strIngredient4: "Braeburn Apples",
                                   strIngredient5: "Butter",
                                   strIngredient6: "Demerara Sugar",
                                   strIngredient7: "Blackberrys",
                                   strIngredient8: "Cinnamon",
                                   strIngredient9: "Ice Cream",
                                   strIngredient10: "",
                                   strIngredient11: "",
                                   strIngredient12: "",
                                   strIngredient13: "",
                                   strIngredient14: "",
                                   strIngredient15: "",
                                   strIngredient16: "",
                                   strIngredient17: "",
                                   strIngredient18: "",
                                   strIngredient19: "",
                                   strIngredient20: "",
                                   strMeasure1: "120g",
                                   strMeasure2: "60g",
                                   strMeasure3: "60g",
                                   strMeasure4: "300g",
                                   strMeasure5: "30g",
                                   strMeasure6: "30g",
                                   strMeasure7: "120g",
                                   strMeasure8: "¼ teaspoon",
                                   strMeasure9: "to serve",
                                   strMeasure10: "",
                                   strMeasure11: "",
                                   strMeasure12: "",
                                   strMeasure13: "",
                                   strMeasure14: "",
                                   strMeasure15: "",
                                   strMeasure16: "",
                                   strMeasure17: "",
                                   strMeasure18: "",
                                   strMeasure19: "",
                                   strMeasure20: "")
        let desserts = try await sut.fetchDessert(byId: "52893")
        XCTAssertEqual(desserts, expectedDessert)
    }
    
    func test_fetchDessertById_failsWithInvalidServerResponse() async throws {
        httpClient.failure = .invalidServerResponse
        var catchedError: HTTPError?
        do {
            let _ = try await sut.fetchDessert(byId: "52893")
            XCTFail("Fetching should fail")
        } catch {
            catchedError = error as? HTTPError
        }
        
        XCTAssertEqual(catchedError, HTTPError.invalidServerResponse)
    }
    
    func test_fetchDessertById_failsWithParseError() async throws {
        httpClient.failure = .parseError
        var catchedError: HTTPError?
        do {
            let _ = try await sut.fetchDessert(byId: "52893")
            XCTFail("Fetching should fail")
        } catch {
            catchedError = error as? HTTPError
        }
        
        XCTAssertEqual(catchedError, HTTPError.parseError)
    }
    
    func test_fetchDessertById_failsWithInvalidURL() async throws {
        httpClient.failure = .invalidURL
        var catchedError: HTTPError?
        do {
            let _ = try await sut.fetchDessert(byId: "52893")
            XCTFail("Fetching should fail")
        } catch {
            catchedError = error as? HTTPError
        }
        
        XCTAssertEqual(catchedError, HTTPError.invalidURL)
    }
}
