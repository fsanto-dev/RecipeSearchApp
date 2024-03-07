@testable import DataStore_Impl
import Model
import XCTest

class RecipeDataStoreImplTests: XCTestCase {
    var sut: RecipeDataStoreImpl!
    
    override func setUp() {
        super.setUp()
        sut = RecipeDataStoreImpl()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSaveRecipe() {
        let recipe = RecipeModel(recipe: Recipe(uri: "1"), image: nil)
        
        sut.saveRecipe(recipe)
        
        let savedRecipes = sut.getRecipes()
        XCTAssertTrue(savedRecipes.contains(recipe), "Saved recipes should contain the added recipe")
    }
    
    func testGetRecipes() {
        let recipe1 = RecipeModel(recipe: Recipe(uri: "1"), image: nil)
        let recipe2 = RecipeModel(recipe: Recipe(uri: "2"), image: nil)
        
        sut.saveRecipe(recipe1)
        sut.saveRecipe(recipe2)
        
        let savedRecipes = sut.getRecipes()
        XCTAssertEqual(savedRecipes.count, 2, "Number of saved recipes should be 2")
        XCTAssertTrue(savedRecipes.contains(recipe1), "Saved recipes should contain the first added recipe")
        XCTAssertTrue(savedRecipes.contains(recipe2), "Saved recipes should contain the second added recipe")
    }
    
    func testDeleteRecipe() {
        let recipe1 = RecipeModel(recipe: Recipe(uri: "1"), image: nil)
        let recipe2 = RecipeModel(recipe: Recipe(uri: "2"), image: nil)
        
        sut.saveRecipe(recipe1)
        sut.saveRecipe(recipe2)
        
        sut.deleteRecipe(recipe1)
        
        let savedRecipes = sut.getRecipes()
        XCTAssertEqual(savedRecipes.count, 1, "Number of saved recipes should be 1 after deletion")
        XCTAssertFalse(savedRecipes.contains(recipe1), "Saved recipes should not contain the deleted recipe")
        XCTAssertTrue(savedRecipes.contains(recipe2), "Saved recipes should still contain the second recipe")
    }
}
