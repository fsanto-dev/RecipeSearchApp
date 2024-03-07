@testable import Services_Impl
import XCTest

class RecipeSearchApiServiceTests: XCTestCase {
    var sut: RecipeSearchApiService!
    
    override func setUp() {
        super.setUp()
        sut = RecipeSearchApiService.shared
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFetchRecipes_Success() {
        let recipeName = "Chicken"
        
        let expectation = XCTestExpectation(description: "Fetch recipes with chicken")
        sut.searchRecipes(with: recipeName) { (data, error) in
            XCTAssertNotNil(data, "Recipes should not be nil")
            XCTAssertNil(error, "Error should be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchData_Success() {
        let url = "https://edamam-product-images.s3.amazonaws.com/web-img/f1b/f1b95efc6ce040e8d77cc176029af9aa.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEMz%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJIMEYCIQDLWQhkNQkQsyGm%2FmBw0a414JIHnux3Orpx2JQYTswW4gIhANJNSA8hXA%2Bs7qiUyXlm9aSZcT9Wmp4X10oT3z3L8wg2KsIFCMX%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEQABoMMTg3MDE3MTUwOTg2IgwAP0XNKDYP4j4HZyoqlgWZsmVULGBy1b09TxiJ3EwGaMH7EHD56y5v8GrHJhSeEBNyveuKCilmSUTadA%2B6BKxoL7GBwaoRCHVny4nDGqLEeyLozStS%2FABb%2FE%2FSydTzEcsSQGdiK8izBjIeZxqR42Gj15877oBiG5Sanm%2BakrNhPfk4iRTt8Rs5LlEFYD12LOUUvLMEt4ON%2BjbfTYycbUmHgNap%2Bg%2FyOwGjxVwFAc%2FMsvSrbQwL8EMs6qgSOXlStMpL8Zt%2FjZYN7U%2Bzvop1HmNA5lEvSoGIrfnvgVu3w%2BOnihoAAJkqwvsULI1oac8xcLauwy6OAmXcK2dr6YMDkWGoMgMdxhAlnXkoOvGdPQUo9zau10%2Bc4SgLKZHNs9ucBHaBFV8d4xnAIWjhkVPlJtXVpXmcpZLDEZaCxKnWQdsAG4gTIl8ubXw7TBVRSJnouwe2Pfv6AYy2hkauOPRkXGrSqkUO58ifU%2FO5uvvr1qZDeQN5ceU%2Fb0d%2B75OJ1tpmpTEYOXbApsE0ti%2BAIGch8QR5aJcbQqry02Q6QrcZMaAAR%2Bh4baBS2AFHO%2FxVTJT%2BlcT3fUDj1cIHQDJypGTCUWsYZuCBmN%2BlK9B5VDHrJAAZkzUZSvS9xRtxqAYCiq41%2FIJI%2BID1MguBttV1Vft%2FnbE%2F3yO1vCv%2B3JgbUAjGaG7J5EW9UhKJATLjObHgQ%2BnB84V2xnJ8S1lpNvX2%2F1Ofda373OpnjwVIe3kTtZxi9r61hvHm0BBuRE1UQn4nNhJB9nnKLwM5g%2BkFL3KTe9Nab9MF24XyWpjNsPjFW0QPJtIx3Y3Ja7KcYzz%2FlEhpRU2IGapBp9JeTDQqPtuoBxHEsseZeRqNGh3hNQCFqguX4C7PI%2BkhOjQ5bfxMY7Cs1zCArVSr4y%2Fj2TDCuqivBjqwATh1M1gbDi%2Fd9WrSYtm3kkqSXmVOlHIRRIqk1rkixB2uW07sbh1tRq27%2FJ6qQghRjXX7wChg1fgbCOUO9grwTPSTl8fEVT9jYDyIhXM63glSQazADQ0glJlID1vVohGlDb%2Fvswjg8Z3cJ0Kgn2ufLtL4Md8mNojeO%2Bn0nH9dpXM1L2DFqSr12Lsk0NjWsyRTXApxU3JyTT4XGl%2BBD2yBKeigb%2BWodw01CfHaLFFDWN6S&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240307T203723Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFNSKV3XLK%2F20240307%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=ac09daf533e3dc415f6cf0bdaa75e1e82f1b4b5739447dc31e35781857241c01"
        
        let expectation = XCTestExpectation(description: "Fetch data")
        sut.fetchData(for: url) { (data, error) in
            XCTAssertNotNil(data, "Data should not be nil")
            XCTAssertNil(error, "Error should be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchData_InvalidURL() {
        let invalidURL = "invalid-url"
        
        let expectation = XCTestExpectation(description: "Fetch data with invalid URL")
        sut.fetchData(for: invalidURL) { (data, error) in
            XCTAssertNil(data, "Data should be nil for an invalid URL")
            XCTAssertNotNil(error, "Error should not be nil for an invalid URL")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}
