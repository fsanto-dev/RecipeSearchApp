import XCTest

final class RecipeSearchAppUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testSavedRecipesButton() throws {
        let app = XCUIApplication()
        app.launch()
        let savedRecipesButton = app/*@START_MENU_TOKEN@*/.staticTexts["Click to see all saved recipes"]/*[[".buttons[\"Click to see all saved recipes\"].staticTexts[\"Click to see all saved recipes\"]",".staticTexts[\"Click to see all saved recipes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(savedRecipesButton.exists)
        savedRecipesButton.tap()
    }
    
    func testSearchBar() throws {
        let app = XCUIApplication()
        app.launch()
        let searchRecipesSearchField = app.navigationBars["Recipe Search"].searchFields["Search Recipes"]
        XCTAssertTrue(searchRecipesSearchField.exists)
        searchRecipesSearchField.tap()
        
        XCTAssertTrue(searchRecipesSearchField.exists)
        searchRecipesSearchField.tap()
        
        searchRecipesSearchField.typeText("Chicken")
        
        let searchButton = app.buttons["Search"]
        XCTAssertTrue(searchButton.exists)
        searchButton.tap()
    }
    
    func testHomepageBookmark() throws {
        let app = XCUIApplication()
        app.launch()
        
        let firstCell = app.tables.element(boundBy: 0).cells.element(boundBy: 0)
        
        sleep(2)
        
        XCTAssertTrue(firstCell.exists)
        
        let bookmarkButton = firstCell.buttons["bookmark"]
        XCTAssertTrue(bookmarkButton.exists)
        
        bookmarkButton.tap()
    }
    
    func testTapCellTapBookmark() throws {
        let app = XCUIApplication()
        app.launch()
        
        let firstCell = app.tables.element(boundBy: 0).cells.element(boundBy: 0)
        
        sleep(2)
        
        XCTAssertTrue(firstCell.exists)
        
        firstCell.tap()
        
        let bookmarkButton = app.buttons["bookmark"]
        XCTAssertTrue(bookmarkButton.exists)
        bookmarkButton.tap()
    }
}
