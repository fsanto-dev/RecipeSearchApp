import DataStore_Api
import Foundation
import Model

public struct RecipeDataStoreImpl: RecipeDataStore {
    public init() { }
    
    public func saveRecipe(_ recipe: RecipeModel) {
        guard let recipeId = recipe.recipe.uri else { return }
        
        var recipes = getRecipes()
        recipes.removeAll { $0.recipe.uri == recipeId }
        recipes.append(recipe)
        
        encodeRecipes(recipes)
    }
    
    public func getRecipes() -> [RecipeModel] {
        return decodeRecipes()
    }
    
    public func deleteRecipe(_ recipe: RecipeModel) {
        guard let recipeId = recipe.recipe.uri else { return }
        
        var recipes = getRecipes()
        recipes.removeAll { $0.recipe.uri == recipeId }
        
        encodeRecipes(recipes)
    }
    
    private func encodeRecipes(_ recipes: [RecipeModel]) {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(recipes)
            UserDefaults.standard.set(encodedData, forKey: Constants.key)
        } catch {
            print(Constants.errorEncoding + error.localizedDescription)
        }
    }
    
    private func decodeRecipes() -> [RecipeModel] {
        if let savedData = UserDefaults.standard.data(forKey: Constants.key) {
            do {
                let decoder = JSONDecoder()
                let array = try decoder.decode([RecipeModel].self, from: savedData)
                return array
            } catch {
                print(Constants.errorEncoding + error.localizedDescription)
            }
        }
        return []
    }
}

// MARK: - Constants Extension

extension RecipeDataStoreImpl {
    private enum Constants {
        static let key: String = "Recipes"
        static let errorEncoding: String = "Error encoding array of structs: "
    }
}
