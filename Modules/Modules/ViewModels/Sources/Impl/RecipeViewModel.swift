import DataStore_Api
import Foundation
import Model
import Services_Api
import ViewModels_Api

public class RecipeViewModel: RecipeViewModelProtocol {
    private let service: RecipeSearchService
    private let dataStore: RecipeDataStore
    
    public weak var delegate: RecipeListDelegate?
    
    public var recipes: [RecipeModel] = [] {
        didSet {
            delegate?.reloadData()
        }
    }
    
    public init(service: RecipeSearchService, dataStore: RecipeDataStore) {
        self.service = service
        self.dataStore = dataStore
        fetchInitialRecipes()
    }
    
    public func fetchRecipe(name: String) {
        recipes = []
        service.searchRecipes(with: name) { [weak self] (data, error) in
            if let error {
                print(error)
            }
            
            if let data {
                let recipes = data.hits?.compactMap { $0.recipe } ?? []
                self?.fetchRecipesImage(for: recipes)
            }
        }
    }
    
    public func onSavedButtonTapped() {
        recipes = dataStore.getRecipes()
    }
    
    public func isRecipeSaved(_ recipe: RecipeModel) -> Bool {
        return dataStore.getRecipes().contains { $0 == recipe }
    }
    
    private func fetchInitialRecipes() {
        fetchRecipe(name: Constants.chefSuggestion)
    }
    
    private func fetchRecipesImage(for recipes: [Recipe]) {
        for recipe in recipes {
            guard let recipeImage = recipe.image else { continue }
            
            service.fetchData(for: recipeImage) { [weak self] data, error in
                if let error {
                    print(error)
                }
                
                if let data {
                    self?.recipes.append(
                        RecipeModel(recipe: recipe, image: data)
                    )
                }
            }
        }
    }
}

extension RecipeViewModel: RecipeTableViewCellDelegate {
    public func onSaveButton(with index: Int) {
        let recipe = recipes[index]
        if isRecipeSaved(recipe) {
            dataStore.deleteRecipe(recipe)
        } else {
            dataStore.saveRecipe(recipe)
        }
    }
}

// MARK: - Constants Extension

extension RecipeViewModel {
    private enum Constants {
        static let chefSuggestion = "Chicken"
    }
}
