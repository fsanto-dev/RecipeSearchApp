@testable import Coordinators_Impl
import Model
import Views
import XCTest

class AppCoordinatorImplTests: XCTestCase {
    private var mockNavigationController: MockNavigationController!
    private var sut: AppCoordinatorImpl!
    
    override func setUp() {
        super.setUp()
        mockNavigationController = MockNavigationController()
        sut = AppCoordinatorImpl(navigationController: mockNavigationController)
    }
    
    override func tearDown() {
        mockNavigationController = nil
        sut = nil
        super.tearDown()
    }
    
    func testStart() {
        sut.start()
        
        XCTAssertTrue(mockNavigationController.didCallPushViewController, "Expected push view controller call")
        XCTAssertTrue(mockNavigationController.topViewController is RecipeSearchViewController, "Top view controller should be RecipeSearchViewController.")
    }
    
    func testShowDetails() {
        let recipe = RecipeModel(recipe: Recipe(), image: nil)
        
        sut.showDetails(for: recipe)
        
        XCTAssertTrue(mockNavigationController.didCallPushViewController, "Expected push view controller call")
        XCTAssertTrue(mockNavigationController.topViewController is RecipeDetailsViewController, "Top view controller should be RecipeDetailsViewController.")
    }
}
