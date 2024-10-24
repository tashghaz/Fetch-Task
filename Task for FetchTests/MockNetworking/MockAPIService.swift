//
//  MockAPIService.swift
//  Task for FetchTests
//
//  Created by Artashes Ghazaryan on 10/8/24.
//

import XCTest
@testable import Task_for_Fetch

class MockAPIService: APIService {
    var shouldReturnError = false
    var mockRecipes: [Recipe] = []

    override func getRecipes() async throws -> [Recipe] {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        } else {
            return mockRecipes
        }
    }
}
