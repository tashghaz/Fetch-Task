//
//  RecipeViewModelTests.swift
//  Task for FetchTests
//
//  Created by Artashes Ghazaryan on 10/8/24.
//

import XCTest
@testable import Task_for_Fetch

final class RecipeViewModelTests: XCTestCase {

    var viewModel: RecipeViewModel!
    var mockAPIService: MockAPIService!

    @MainActor override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        viewModel = RecipeViewModel(apiService: mockAPIService)  // Injecting mock service
    }

    override func tearDown() {
        viewModel = nil
        mockAPIService = nil
        super.tearDown()
    }

    @MainActor
    func testFetchRecipesSuccess() async {
        let mockRecipes = [
            Recipe(
                id: "1",
                name: "Test Recipe 1",
                photoUrlLarge: nil,
                photoUrlSmall: nil,
                sourceUrl: nil,
                cuisine: "Test Cuisine 1"),
            Recipe(
                id: "2",
                name: "Test Recipe 2",
                photoUrlLarge: nil,
                photoUrlSmall: nil,
                sourceUrl: nil,
                cuisine: "Test Cuisine 2")
        ]
        mockAPIService.mockRecipes = mockRecipes

        // When
        await viewModel.fetchRecipes()

        // Then
        XCTAssertEqual(viewModel.recipes.count, 2)
        XCTAssertEqual(viewModel.recipes[0].name, "Test Recipe 1")
        XCTAssertEqual(viewModel.recipes[1].cuisine, "Test Cuisine 2")
    }

    @MainActor
    func testFetchRecipesEmptyResponse() async {
        // Given
        mockAPIService.mockRecipes = []

        // When
        await viewModel.fetchRecipes()

        // Then
        XCTAssertTrue(viewModel.recipes.isEmpty)
    }

    @MainActor
    func testFetchRecipesFailure() async {
        // Given
        mockAPIService.shouldReturnError = true

        // When
        await viewModel.fetchRecipes()

        // Then
        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage?.message, URLError(.badServerResponse).localizedDescription)
    }
}
