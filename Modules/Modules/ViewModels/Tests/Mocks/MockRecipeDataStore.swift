import DataStore_Api
import Model

class MockRecipeDataStore: RecipeDataStore {
    var savedRecipes: [RecipeModel] = []
    var getRecipesCalled = false
    var saveRecipeCalled = false
    var deleteRecipeCalled = false
    
    func saveRecipe(_ recipe: RecipeModel) {
        saveRecipeCalled = true
        savedRecipes.append(recipe)
    }
    
    func getRecipes() -> [RecipeModel] {
        getRecipesCalled = true
        return savedRecipes
    }
    
    func deleteRecipe(_ recipe: RecipeModel) {
        deleteRecipeCalled = true
        savedRecipes.removeAll { $0 == recipe }
    }
}
