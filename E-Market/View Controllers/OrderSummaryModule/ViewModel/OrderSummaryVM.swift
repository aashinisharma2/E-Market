//
//  OrderSummaryViewModel.swift
//  E-Market
//
//  Created by Aashini on 10/01/22.
//

import Foundation

protocol OrderQuantityManager {
    
    /// Pass this delegate when yuo want to update a product model of deligating calss ( Deligating class = who make it self)
    /// - Parameters:
    ///   - id: Product ID for identification
    ///   - quantiy: Product quantiy with we want to update
    
    func quantiyChanged(id: Int , quantiy: Int)
}

class OrderSummaryViewModel {
    
    //Mark: Properties
    var quantityManager: OrderQuantityManager? = nil
    var products:[Product] = []
    var subTotal = 0
    var address: String = ""
    
}

//API integrations
extension OrderSummaryViewModel {
    
    func convertToDict()-> [String:Any] {
        
        var dict:[String: Any] = [:]
        
        let product = self.products.map { prod in
            prod.jsonDict
        }
        dict[ApiKey.product] = product
        dict[ApiKey.delivery_address] = address
        return dict
    }

    //To post an order to server
    func hitPostOrderApi(completionHandler : @escaping(String?)->Void) {
        NetworkManager.shared.postData(url: AppUrl.postOrder.value, param: convertToDict()) { data, error in
            
            if(error != nil) {
                
                completionHandler(error?.localizedDescription)
            } else {
                completionHandler(nil)

            }
        }
    }
}

//Busines logic functions
extension OrderSummaryViewModel {
    
    func populateData(_product: Product)-> Product {
        
        var product = _product
        if product.quantity != 0 {
            product.price = (product.price ?? 0) * (product.quantity ?? 1)
        }
        return product
    }
    
    func updateSubTotal() {
        
        subTotal = 0
        for count in 0..<products.count {
            if (products[count].quantity != nil) && products[count].quantity != 0 {
                subTotal += (products[count].price ?? 0) * ( products[count].quantity ?? 1)
            }
        }
        return
    }
    
    func filterData() {
        
        let filteredData = products.filter { product in
            if product.quantity == nil {
                return false
            }
            return product.quantity ?? 0 > 0 && (product.isSelected ?? false)
        }
        products = filteredData
    }
}
