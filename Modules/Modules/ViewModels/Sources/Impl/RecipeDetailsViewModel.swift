import DataStore_Api
import Foundation
import Model
import Services_Api
import ViewModels_Api

public class RecipeDetailsViewModel: RecipeDetailsViewModelProtocol {
    private let dataStore: RecipeDataStore
    public let recipe: RecipeModel
    
    public init(recipe: RecipeModel, dataStore: RecipeDataStore) {
        self.recipe = recipe
        self.dataStore = dataStore
    }
    
    public func onSaveButton() {
        if isRecipeSaved(recipe) {
            dataStore.deleteRecipe(recipe)
        } else {
            dataStore.saveRecipe(recipe)
        }
    }
    
    public func isRecipeSaved(_ recipe: RecipeModel) -> Bool {
        return dataStore.getRecipes().contains(where: { $0 == recipe })
    }
}
