//
//  StoreDetailVMTests.swift
//  E-MarketTests
//
//  Created by Aashini on 11/01/22.
//

import XCTest
@testable import E_Market

class StoreDetailVMTests: XCTestCase {
    
    // MARK: - Properties
    //====================
    var viewModel: StoreDetailViewModel?
    
    // MARK: - Instance Methods
    //==========================
    override func setUp() {
        super.setUp()
        viewModel = StoreDetailViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    override func setUpWithError() throws {
        viewModel = StoreDetailViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    // MARK: - Test Methods
    //======================
    func testGetProductInfo_Success_ReturnData() throws {
        //Arrange
        var error: String?
        let exp = expectation(description: "GetProduct is successful")
        var failed: Bool?
        
        //Act and Assert
        viewModel?.getProductInfo(completionHandler: { err in
            if err != nil{
                error = err
                failed = true
            } else {
                error = nil
            }
            exp.fulfill()
        })
        
        //Assert
        self.waitForExpectations(timeout: 5) { err in
            if let err = err {
                XCTFail("waitForExpectationsWithTimeout errored: \(err)")
            }
            if failed ?? false {
                XCTAssertNil(error)
                XCTAssertNotNil(self.viewModel?.products)
            }
        }
    }
    
    func testGetProductInfo_Failure_NoData() throws {
        //Arrange
        var error: String?
        let exp = expectation(description: "Getproduct is Failed")
        var failed: Bool?
        
        //Act and Assert
        viewModel?.getProductInfo(completionHandler: { err in
            if err != nil{
                error = err
                failed = true
            } else {
                error = nil
            }
            exp.fulfill()
        })
        
        //Assert
        self.waitForExpectations(timeout: 5) { err in
            if let err = err {
                XCTFail("waitForExpectationsWithTimeout errored: \(err)")
            }
            if failed ?? false {
                XCTAssertNotNil(error)
                XCTAssertNil(self.viewModel?.products)
            }
        }
    }
    
    func testGetStoreInfo_Success_ReturnData() throws {
        //Arrange
        var error: String?
        let exp = expectation(description: "GetStore is successful")
        var failed: Bool?
        //Act and Assert
        viewModel?.getStoreInfo(completionHandler: { err in
            if err != nil{
                error = err
                failed = true
            } else {
                error = nil
            }
            exp.fulfill()
        })
        
        //Assert
        self.waitForExpectations(timeout: 5) { err in
            if let err = err {
                XCTFail("waitForExpectationsWithTimeout errored: \(err)")
            }
            if failed ?? false {
                XCTAssertNil(error)
                XCTAssertNotNil(self.viewModel?.store)
            }
        }
    }
    
    func testGetStoreInfo_Failure_NoData() throws {
        //Arrange
        var error: String?
        let exp = expectation(description: "GetStore is Failed")
        var failed: Bool?
        //Act and Assert
        viewModel?.getStoreInfo(completionHandler: { err in
            if err != nil{
                error = err
                failed = true
            } else {
                error = nil
            }
            exp.fulfill()
        })
        
        //Assert
        self.waitForExpectations(timeout: 5) { err in
            if let err = err {
                XCTFail("waitForExpectationsWithTimeout errored: \(err)")
            }
            if failed ?? false {
                XCTAssertNotNil(error)
                XCTAssertNil(self.viewModel?.store)
            }
        }
    }
    
    func testFetchData_WhenSuccess_ReturnData() {
        //Arrange
        var err: String?
        var dataStatus: Bool?
        let exp = expectation(description: "GetData is successful")
        
        //Act
        viewModel?.fecthData(completion: {(status , msg) in
            if status ?? false{
                dataStatus = status
                err = nil
            } else {
                err = msg
            }
            exp.fulfill()
        })
        
        //Assert
        self.waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssert((dataStatus != nil))
            XCTAssertNil(err)
        }
    }
}

