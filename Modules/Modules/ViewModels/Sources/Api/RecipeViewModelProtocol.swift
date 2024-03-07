import Model

public protocol RecipeViewModelProtocol: RecipeTableViewCellDelegate {
    var recipes: [RecipeModel] { get }
    func fetchRecipe(name: String)
    func isRecipeSaved(_ recipe: RecipeModel) -> Bool
    func onSavedButtonTapped()
}
