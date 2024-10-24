//
//  RecipeViewModel.swift
//  Task for Fetch
//
//  Created by Artashes Ghazaryan on 10/8/24.
//

import Foundation
import SwiftUI

@MainActor
class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var errorMessage: ErrorMessage?

    private var apiService = APIService()

    // Custom initializer to allow dependency injection
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }

    func fetchRecipes() async {
        do {
            self.recipes = try await apiService.getRecipes()
        } catch let DecodingError.dataCorrupted(context) {
            print("Data corrupted:", context.debugDescription)
            self.errorMessage = ErrorMessage(message: "Data is corrupted.")
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            self.errorMessage = ErrorMessage(message: "Key not found: \(key).")
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            self.errorMessage = ErrorMessage(message: "Value not found: \(value).")
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            self.errorMessage = ErrorMessage(message: "Type mismatch: \(type).")
        } catch {
            print("Other error:", error.localizedDescription)
            self.errorMessage = ErrorMessage(message: error.localizedDescription)
        }
    }
}

struct ErrorMessage: Identifiable {
    var id: String { message }
    let message: String
}
