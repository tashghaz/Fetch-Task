//
//  ContentView.swift
//  Task for Fetch
//
//  Created by Artashes Ghazaryan on 10/8/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = RecipeViewModel()

        var body: some View {
            NavigationView {
                List(viewModel.recipes) { recipe in
                    HStack {
                        // Ensure the URL is valid and load the large image, or show a placeholder if not available
                        if let url = URL(string: recipe.photoUrlLarge ?? "") {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                            } placeholder: {
                                ProgressView()
                            }
                        } else {
                            // Show a default placeholder if the URL is invalid or missing
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }

                        VStack(alignment: .leading) {
                            Text(recipe.name)
                                .font(.headline)

                            // Check if cuisine is available and show it, otherwise fallback to default text
                            Text(recipe.cuisine ?? "Unknown Cuisine")
                                .font(.subheadline)
                        }
                    }
                }
                .refreshable {
                    await viewModel.fetchRecipes()
                }
                .navigationTitle("Recipes")
            }
            .onAppear {
                Task {
                    await viewModel.fetchRecipes()
                }
            }
            .alert(item: $viewModel.errorMessage) { errorMessage in
                Alert(title: Text("Error"), message: Text(errorMessage.message), dismissButton: .default(Text("OK")))
            }
        }
}


#Preview {
    ContentView()
}
