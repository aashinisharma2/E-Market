//
//  OrderDetailSummaryVCUITests.swift
//  E-MarketUITests
//
//  Created by Aashini on 12/01/22.
//

import XCTest
@testable import E_Market

class OrderDetailSummaryVCUITests: XCTestCase {
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
        var app = XCUIApplication()
        var navigationBar = app.navigationBars["Store Detail"]
        let cartButton = navigationBar.buttons["shopping cart"]
        
        //Act
        cartButton.tap()
        app = XCUIApplication()
        navigationBar = app.navigationBars.firstMatch
        let backButton = navigationBar.buttons["Store Detail"]
        
        //Assert
        XCTAssert(navigationBar.exists)
        XCTAssert(backButton.exists)
    }
    
    func testTableviewElements_Existence() throws {
        //Arrange
        var app = XCUIApplication()
        let navigationBar = app.navigationBars["Store Detail"]
        let cartButton = navigationBar.buttons["shopping cart"]
        
        //Act
        cartButton.tap()
        app = XCUIApplication()
        let tablesQuery = app.tables
        let proceedToBuyButton = app.buttons["Proceed to Buy"]
        
        //Assert
        XCTAssert(tablesQuery.element.exists)
        XCTAssert(proceedToBuyButton.exists)
    }
    
    func testBuyButton_WhenTapped_ShowsAlert() throws {
        //Arrange
        var app = XCUIApplication()
        let navigationBar = app.navigationBars["Store Detail"]
        let cartButton = navigationBar.buttons["shopping cart"]
        
        //Act
        cartButton.tap()
        app = XCUIApplication()
        let proceedToBuyButton = app.buttons["Proceed to Buy"]
        proceedToBuyButton.tap()
        let addDeliveryAddressAlert = app.alerts["Add Delivery Address\n\n\n\n\n"]
        let textView = addDeliveryAddressAlert.children(matching: .textView).element
        let submitButton = addDeliveryAddressAlert.buttons["Submit"]
        let cancelButton = addDeliveryAddressAlert.buttons["Cancel"]
        
        //Assert
        XCTAssert(addDeliveryAddressAlert.exists)
        XCTAssert(textView.exists)
        XCTAssert(submitButton.exists)
        XCTAssert(cancelButton.exists)
    }
    
    func testAlert_WhenSubmitTapped_dismissAlert() throws {
        //Arrange
        var app = XCUIApplication()
        let navigationBar = app.navigationBars["Store Detail"]
        let cartButton = navigationBar.buttons["shopping cart"]
        
        //Act
        cartButton.tap()
        app = XCUIApplication()
        let proceedToBuyButton = app.buttons["Proceed to Buy"]
        proceedToBuyButton.tap()
        let addDeliveryAddressAlert = app.alerts["Add Delivery Address\n\n\n\n\n"]
        let submitButton = addDeliveryAddressAlert.buttons["Submit"]
        submitButton.tap()
        
        //Assert
        XCTAssertFalse(addDeliveryAddressAlert.exists)
    }
    
    func testAlert_WhenCancelTapped_dismissAlert() throws {
        //Arrange
        var app = XCUIApplication()
        let navigationBar = app.navigationBars["Store Detail"]
        let cartButton = navigationBar.buttons["shopping cart"]
        
        //Act
        cartButton.tap()
        app = XCUIApplication()
        let proceedToBuyButton = app.buttons["Proceed to Buy"]
        proceedToBuyButton.tap()
        let addDeliveryAddressAlert = app.alerts["Add Delivery Address\n\n\n\n\n"]
        let cancelButton = addDeliveryAddressAlert.buttons["Cancel"]
        cancelButton.tap()
        
        //Assert
        XCTAssertFalse(addDeliveryAddressAlert.exists)
    }
}
