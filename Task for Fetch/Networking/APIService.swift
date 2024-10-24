//
//  APIService.swift
//  Task for Fetch
//
//  Created by Artashes Ghazaryan on 10/8/24.
//

import Foundation

class APIService {
    private let urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"

    func getRecipes() async throws -> [Recipe] {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)

        // Debug print to inspect the raw JSON
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Raw JSON Response: \(jsonString)")
        }

        // Decode the response where the array is nested inside the "recipes" key
        let decodedResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
        return decodedResponse.recipes
    }
}

struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}
