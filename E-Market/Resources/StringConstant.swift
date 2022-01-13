//
//  StringConstant.swift
//  E-Market
//
//  Created by Aashini on 12/01/22.
//

import Foundation

enum StringConstant: String {
    
    case storeDetail        = "Store Detail"
    case pullToRefresh      = "Pull to refresh"
    case rating             = "Rating"
    case openingTime        = "Opening Time"
    case closingTime        = "Closing Time"
    case addToCart          = "Add to cart"
    case selectProductToBuy = "Select Product(s) to buy"
    case bounds             = "bounds"
    case addDeliveryDetails = "Add Delivery Address"
    case cancel             = "Cancel"
    case submit             = "Submit"
    case subTotal           = "Subtotal: "
    case proceedToBuy       = "Proceed to Buy"
}


extension StringConstant {
    
    var value: String {
        
        return self.rawValue.localized
    }
}

