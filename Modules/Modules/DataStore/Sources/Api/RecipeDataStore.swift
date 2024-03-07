import Model

public protocol RecipeDataStore {
    func saveRecipe(_ recipe: RecipeModel)
    func getRecipes() -> [RecipeModel]
    func deleteRecipe(_ recipe: RecipeModel)
}
