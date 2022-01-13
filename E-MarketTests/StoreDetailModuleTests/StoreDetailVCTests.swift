//
//  StoreDetailVCTests.swift
//  E-MarketTests
//
//  Created by Aashini on 11/01/22.
//

import XCTest
@testable import E_Market

class StoreDetailVCTests: XCTestCase {
    
    // MARK: - Properties
    //====================
    var sut: StoreDetailViewController!
    var navigationController: UINavigationController!
    
    // MARK: - Instance Methods
    //==========================
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        sut = storyboard.instantiateViewController(withIdentifier: "StoreDetailViewController") as? StoreDetailViewController
        sut.loadViewIfNeeded()
        navigationController = UINavigationController(rootViewController: sut)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        navigationController = nil
    }
    
    // MARK: - Test Methods
    //======================
    func testConnectionWithOutlet() throws {
        _ = try XCTUnwrap(sut.storeProductsTabelView, "storeProductsTabelView is not connected")
        _ = try XCTUnwrap(sut.storeInfoView, "storeProductsTabelView is not connected")
        _ = try XCTUnwrap(sut.storeNameLabel, "storeProductsTabelView is not connected")
        _ = try XCTUnwrap(sut.ratingLabel, "storeProductsTabelView is not connected")
        _ = try XCTUnwrap(sut.openingTimeLabel, "storeProductsTabelView is not connected")
        _ = try XCTUnwrap(sut.closingTimeLabel, "storeProductsTabelView is not connected")
        _ = try XCTUnwrap(sut.productsHeadingLabel, "productsHeadingLabel is not connected")
    }
    
    func testCartButton_WhenTapped_OrderSummaryViewControllerIsPushed() throws {
        //Arrange
            let myPredicate = NSPredicate { input, _ in
            return (input as? UINavigationController)?.topViewController is OrderSummaryViewController
        }
        
        //Act
        self.expectation(for: myPredicate, evaluatedWith: navigationController)
        sut.routeToCartController()
        waitForExpectations(timeout: 5)
    }
    
    func testCartButton_WhenTapped_OrderSummaryViewControllerIsPushed2() throws {
        // Act
        sut.routeToCartController()
        RunLoop.current.run(until: Date())
        
        // Assert
        guard let _ = navigationController.topViewController as? OrderSummaryViewController else {
            XCTFail()
            return
        }
    }
    
    func testFetchData_WhenCalled_Success() throws {
        //Act and Assert
        sut.fetchData()
        
        if sut.dataStatus {
            XCTAssertNotNil(sut.viewModel.store)
            XCTAssertNotNil(sut.viewModel.products)
        }
    }
    
    func testFetchData_WhenCalled_Failure() throws {
        //Act and Assert
        sut.fetchData()
        
        if !sut.dataStatus {
            XCTAssertNil(sut.viewModel.store)
            XCTAssertNil(sut.viewModel.products)
        }
    }
}
