//
//  ProductsCellUITests.swift
//  E-MarketUITests
//
//  Created by Aashini on 11/01/22.
//

import XCTest
@testable import E_Market

class ProductsCellTests: XCTestCase {
    
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
    func testCellElement_Existence() {
        //Arrange
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        let minusButton = cell.buttons.staticTexts["-"]
        let plusButton = cell.buttons.staticTexts["+"]
        let exists = NSPredicate(format: "exists == true")
        let productNameLabel = cell.children(matching: .staticText).element(boundBy: 0)
        let priceLabel = cell.children(matching: .staticText).element(boundBy: 1)
        let quantityLabel = cell.children(matching: .staticText).element(boundBy: 2)
        let image = cell.images
        
        //Act
        expectation(for: exists, evaluatedWith: cell, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        //Assert
        XCTAssert(cell.exists)
        XCTAssert(productNameLabel.exists)
        XCTAssert(priceLabel.exists)
        XCTAssert(plusButton.exists)
        XCTAssert(minusButton.exists)
        XCTAssert(quantityLabel.exists)
        XCTAssert(image.firstMatch.exists)
    }
    
    func testPlusButton_WhenTapped_IncreaseQuantitySuccess() throws {
        //Arrange
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        let plusButton = cell.buttons.staticTexts["+"]
        let quantityLabel = cell.children(matching: .staticText).element(boundBy: 2)
        let quantity1 = Int(quantityLabel.label) ?? 0
        let exists = NSPredicate(format: "exists == true")
//        XCUIApplication().tables.children(matching: .cell).element(boundBy: 0).staticTexts["0"].tap()
        
        //Act
        expectation(for: exists, evaluatedWith: cell, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        plusButton.tap()
        let quantity2 = Int(quantityLabel.label) ?? 0
        
        //Assert
        XCTAssertEqual(quantity1 + 1, quantity2)
    }
    
    func testPlusButton_WhenTapped_IncreaseQuantityFailure() throws {
        //Arrange
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        let plusButton = cell.buttons.staticTexts["+"]
        let quantityLabel = cell.children(matching: .staticText).element(boundBy: 2)
        let quantity1 = Int(quantityLabel.label) ?? 0
        let exists = NSPredicate(format: "exists == true")
        //XCUIApplication().tables.children(matching: .cell).element(boundBy: 0).staticTexts["1"].tap()
        
        //Act
        expectation(for: exists, evaluatedWith: cell, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        plusButton.tap()
        let quantity2 = Int(quantityLabel.label) ?? 0
        
        //Assert
        XCTAssertNotEqual(quantity1, quantity2)
    }
    
    func testMinusButton_WhenTapped_DecreaseQuantitySuccess() throws {
        //Arrange
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        let minusButton = cell.buttons.staticTexts["-"]
        let quantityLabel = cell.children(matching: .staticText).element(boundBy: 2)
        let quantity1 = Int(quantityLabel.label) ?? 0
        let exists = NSPredicate(format: "exists == true")
        //XCUIApplication().tables.children(matching: .cell).element(boundBy: 0).staticTexts["0"].tap()
        
        //Act
        expectation(for: exists, evaluatedWith: cell, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        minusButton.tap()
        let quantity2 = Int(quantityLabel.label) ?? 0
        
        //Assert
        if quantity1 > 1 {
            XCTAssertEqual(quantity1 - 1, quantity2)
        }
    }
    
    func testMinusButton_WhenTapped_DecreaseQuantityFailure() throws {
        //Arrange
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        let minusButton = cell.buttons.staticTexts["-"]
        let quantityLabel = cell.children(matching: .staticText).element(boundBy: 2)
        let quantity1 = Int(quantityLabel.label) ?? 0
        let exists = NSPredicate(format: "exists == true")
//        XCUIApplication().tables.children(matching: .cell).element(boundBy: 0).staticTexts["0"].tap()
        
        //Act
        expectation(for: exists, evaluatedWith: cell, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        minusButton.tap()
        let quantity2 = Int(quantityLabel.label) ?? 0
        
        //Assert
        if quantity1 > 1 {
            XCTAssertNotEqual(quantity1 - 1, quantity2)
        }
    }
}
