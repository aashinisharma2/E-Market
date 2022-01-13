//
//  StoreDetailVCUITests.swift
//  E-MarketUITests
//
//  Created by Aashini on 11/01/22.
//

import XCTest
@testable import E_Market

class StoreDetailVCUITests: XCTestCase {

    //MARK: - Properties
    //===================
    let app = XCUIApplication()
    
    //MARK: - Instance Methods
    //=========================
    override func setUp() {
        super.setUp()
        continueAfterFailure = true
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    //MARK: - Test Methods
    //======================
    func testNavigationBarElement_Existence() throws {
        //Arrange
        let app = XCUIApplication()
        let navigationBar = app.navigationBars["Store Detail"]
        
        //Act and Assert
        XCTAssert(navigationBar.exists)
    }
    
    func testTableviewElements_Existence() throws {
        // Arrange
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        let exists = NSPredicate(format: "exists == true")

        //Act
        expectation(for: exists, evaluatedWith: cell, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        //Assert
        XCTAssert(tablesQuery.element.exists)
        XCTAssert(cell.exists)
    }
    
    func testCellElement_Existence() throws {
            //Arrange
            let app = XCUIApplication()
            let tablesQuery = app.tables
            let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
            let minusButton = cell.buttons.staticTexts["-"]
            let plusButton = cell.buttons.staticTexts["+"]
            let productNameLabel = cell.staticTexts.element(boundBy: 0)
            let priceLabel = cell.staticTexts.element(boundBy: 1)
            let quantityLabel = cell.staticTexts.element(boundBy: 2)
            let image = cell.images.firstMatch
            let exists = NSPredicate(format: "exists == true")
        
            //Act
            expectation(for: exists, evaluatedWith: cell, handler: nil)
            waitForExpectations(timeout: 5, handler: nil)
        
            //Assert
            XCTAssert(productNameLabel.exists)
            XCTAssert(priceLabel.exists)
            XCTAssert(plusButton.exists)
            XCTAssert(minusButton.exists)
            XCTAssert(quantityLabel.exists)
            XCTAssert(image.exists)
        }
    
    func testAddToCartButton_WhenTapped_AddItemToCart() throws {
        // Arrange
        var app = XCUIApplication()
        var tablesQuery = app.tables
        var cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        let addToCartButton = app.buttons["Add to Cart"]
        let exists = NSPredicate(format: "exists == true")

        //Act
        expectation(for: exists, evaluatedWith: cell, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        addToCartButton.tap()
        app = XCUIApplication()
        tablesQuery = app.tables
        cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        
        //Assert
        XCTAssert(cell.exists)
    }
}
