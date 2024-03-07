import Model
import Foundation

public protocol RecipeSearchService {
    func searchRecipes(
        with name: String,
        completion: @escaping (Recipes?, ServiceError?) -> Void
    )
    
    func fetchData(
        for url: String,
        completion: @escaping (Data?, ServiceError?) -> Void
    )
}
