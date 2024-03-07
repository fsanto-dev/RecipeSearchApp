@testable import ViewModels_Impl
import Model
import XCTest

class RecipeViewModelTests: XCTestCase {
    var sut: RecipeViewModel!
    var mockService: MockRecipeSearchService!
    var mockDataStore: MockRecipeDataStore!
    
    override func setUp() {
        super.setUp()
        mockService = MockRecipeSearchService()
        mockDataStore = MockRecipeDataStore()
        sut = RecipeViewModel(service: mockService, dataStore: mockDataStore)
    }
    
    override func tearDown() {
        sut = nil
        mockService = nil
        mockDataStore = nil
        super.tearDown()
    }
    
    func testFetchRecipe() {
        sut.fetchRecipe(name: "Chicken")
        XCTAssertTrue(mockService.searchRecipesCalled)
    }
    
    func testIsRecipeSaved_NotSavedRecipe() {
        let mockRecipe = RecipeModel(recipe: Recipe(uri: ""), image: nil)
        XCTAssertFalse(sut.isRecipeSaved(mockRecipe))
    }
    
    func testIsRecipeSaved_SavedRecipe() {
        let mockRecipe = RecipeModel(recipe: Recipe(uri: ""), image: nil)
        mockDataStore.savedRecipes = [mockRecipe]
        XCTAssertTrue(sut.isRecipeSaved(mockRecipe))
    }
    
    func testOnSaveButtonTapped_SavedRecipe() {
        let mockRecipe = RecipeModel(recipe: Recipe(uri: ""), image: nil)
        mockDataStore.savedRecipes = [mockRecipe]
        sut.onSavedButtonTapped()
        XCTAssertTrue(sut.recipes.contains(mockRecipe))
    }
    
    func testOnSaveButtonTapped_NotSavedRecipe() {
        let mockRecipe = RecipeModel(recipe: Recipe(uri: ""), image: nil)
        mockDataStore.savedRecipes = []
        sut.onSavedButtonTapped()
        XCTAssertFalse(sut.recipes.contains(mockRecipe))
    }
}
