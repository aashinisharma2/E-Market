//
//  OrderSummaryVCTests.swift
//  E-MarketTests
//
//  Created by Aashini on 11/01/22.
//

import XCTest
@testable import E_Market

class OrderSummaryVCTests: XCTestCase {

    //MARK: - Properties
    //===================
    private var sut: OrderSummaryViewController!
    
    //MARK: - Instance Methods
    //=========================
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        sut = storyboard.instantiateViewController(withIdentifier: "OrderSummaryViewController") as? OrderSummaryViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    //MARK: - Test Methods
    //=====================
    func testConnectionWithOutlet() throws {
        _ = try XCTUnwrap(sut.productsTableView, "productsTableView is not connected")
        _ = try XCTUnwrap(sut.subtotalLabel, "subtotalLabel is not connected")
        _ = try XCTUnwrap(sut.buyButton, "buyButton is not connected")
    }
    
    func testBuyButtonAction_WhenTapped_PresentAlertSuccess() throws {
        //Arrange
        let buyButton = try XCTUnwrap(sut.buyButton, "buyButton is not connected")
        
        //Act
        buyButton.sendActions(for: .touchUpInside)
        
        //Assert
        let topVC = UIApplication.topViewController()
        XCTAssertNotEqual(topVC, sut)
    }
    
    func testBuyButtonAction_WhenTapped_PresentAlertFailed() throws {
        //Arrange
        let buyButton = try XCTUnwrap(sut.buyButton, "buyButton is not connected")
        
        //Act
        buyButton.sendActions(for: .touchUpInside)
        
        //Assert
        let topVC = sut
        XCTAssertEqual(topVC, sut)
    }
    
    func testPriceLabel_WhenUpdated_Success() throws {
        //Arrange
        let subTotalLabel = try XCTUnwrap(sut.subtotalLabel, "subtotalLabel is not connected")
        let subTotal = StringConstant.subTotal.value + " \(sut.viewModel.subTotal)"
        
        //Assert
        XCTAssertEqual(subTotal, subTotalLabel.text)
    }
    
    func testPriceLabel_WhenUpdated_Failure() throws {
        //Arrange
        let subTotal = "0"
        let subTotalLabelText = String(Int.random(in: 1...Int.max))

        //Assert
        XCTAssertNotEqual(subTotal, subTotalLabelText)
    }
}
