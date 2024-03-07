import Foundation
import Model
import Services_Api

class MockRecipeSearchService: RecipeSearchService {
    var searchRecipesCalled = false
    var fetchDataCalled = false
    var recipes: [RecipeModel]?
    
    func searchRecipes(with name: String, completion: @escaping (Recipes?, ServiceError?) -> Void) {
        searchRecipesCalled = true
    }
    
    func fetchData(for url: String, completion: @escaping (Data?, ServiceError?) -> Void) {
        fetchDataCalled = true
    }
}
