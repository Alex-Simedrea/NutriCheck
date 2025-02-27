//
//  MediumSuggestedRecipesWidget.swift
//  NutriCheck
//
//  Created by Alexandru Simedrea on 19.12.2024.
//

import CachedAsyncImage
import SwiftUI

struct MediumSuggestedRecipesWidget: View {
    @StateObject private var recipes = RecipeQueries.getRecipeRecommendations()
    @Namespace var namespace
    @State private var showRecipeDetails = false

    var body: some View {
        withQueryProgress(recipes) { recipes in
            let recipe = recipes.first ?? Recipe.EmptyRecipe

            Button(action: { showRecipeDetails.toggle() }) {
                HStack(spacing: 20) {
                    CachedAsyncImage(
                        url: URL(
                            string: recipe.images.first ?? ""
                        )
                    ) { result in
                        switch result {
                        case .empty:
                            Image(systemName: "photo")
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(.rect(cornerRadius: 16))
                        case .failure:
                            Image(systemName: "photo")
                        default:
                            Image(systemName: "photo")
                        }
                    }
                    VStack(alignment: .leading) {
                        Text(recipe.name)
                            .font(.headline.bold())
                            .multilineTextAlignment(.leading)
                        Text("by \(recipe.authorUsername)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 10)
                        HStack {
                            Text("\(recipe.totalTime) m")
                                .font(.subheadline)
                            Divider()
                                .frame(height: 12)
                            Text("\(recipe.difficulty.title)")
                                .font(.subheadline)
                                .foregroundStyle(recipe.difficulty.color)
                            //                        Divider()
                            //                            .frame(height: 12)
                            //                        Text("30m")
                            //                            .font(.subheadline)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .matchedTransitionSource(id: "recipe\(recipe.id)", in: namespace)
            .fullScreenCover(isPresented: $showRecipeDetails) {
                RecipeScreen(recipe: recipe)
                    .navigationTransition(.zoom(sourceID: "recipe\(recipe.id)", in: namespace))
            }
        }
    }
}

#Preview {
    MediumSuggestedRecipesWidget()
}
