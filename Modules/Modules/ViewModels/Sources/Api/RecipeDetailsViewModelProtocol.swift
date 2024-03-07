import Model

public protocol RecipeDetailsViewModelProtocol {
    var recipe: RecipeModel { get }
    func onSaveButton()
    func isRecipeSaved(_ recipe: RecipeModel) -> Bool
}
