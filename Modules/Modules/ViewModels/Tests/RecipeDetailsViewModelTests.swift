@testable import ViewModels_Impl
import Model
import XCTest

class RecipeDetailsViewModelTests: XCTestCase {
    var sut: RecipeDetailsViewModel!
    var mockService: MockRecipeSearchService!
    var mockDataStore: MockRecipeDataStore!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        mockService = nil
        mockDataStore = nil
        super.tearDown()
    }
    
    func testOnSaveButton_SaveRecipe() {
        let mockDataStore = MockRecipeDataStore()
        let mockRecipe = RecipeModel(recipe: Recipe(uri: ""), image: nil)
        let viewModel = RecipeDetailsViewModel(recipe: mockRecipe, dataStore: mockDataStore)
        viewModel.onSaveButton()
        XCTAssertTrue(mockDataStore.getRecipes().contains(mockRecipe))
    }
    
    func testOnSaveButton_DeleteRecipe() {
        let mockDataStore = MockRecipeDataStore()
        let mockRecipe = RecipeModel(recipe: Recipe(uri: "1"), image: nil)
        let viewModel = RecipeDetailsViewModel(recipe: mockRecipe, dataStore: mockDataStore)
        viewModel.onSaveButton()
        viewModel.onSaveButton()
        XCTAssertFalse(mockDataStore.getRecipes().contains(mockRecipe))
    }
    
    func testOnIsRecipeSaved_SavedRecipe() {
        let mockDataStore = MockRecipeDataStore()
        let mockRecipe = RecipeModel(recipe: Recipe(uri: ""), image: nil)
        let viewModel = RecipeDetailsViewModel(recipe: mockRecipe, dataStore: mockDataStore)
        viewModel.onSaveButton()
        XCTAssertTrue(viewModel.isRecipeSaved(mockRecipe))
    }
    
    func testOnIsRecipeSaved_NotSavedRecipe() {
        let mockDataStore = MockRecipeDataStore()
        let mockRecipe = RecipeModel(recipe: Recipe(uri: ""), image: nil)
        let viewModel = RecipeDetailsViewModel(recipe: mockRecipe, dataStore: mockDataStore)
        XCTAssertFalse(viewModel.isRecipeSaved(mockRecipe))
    }
}
