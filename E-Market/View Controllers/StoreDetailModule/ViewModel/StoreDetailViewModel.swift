//
//  StoreDetailViewModel.swift
//  E-Market
//
//  Created by Aashini on 09/01/22.
//

import Foundation

class StoreDetailViewModel {
    
    //Mark: Properties
    private var productRequestUseCase : ProductRequestUseCase?
    private var storeRequestUseCase   : StoreRequestUseCase?
    
    var boolLoading : Bool = false
    var products : [Product]?
    var itemsIncard: [Product] = []
    var store : Store?
    var totalItemsInCard: Int = 0
    
    //Fetch data from API using dispatch group
    func fecthData(completion: @escaping(_ isSucces: Bool? , _ message: String)->Void) {
       
        var status = true
        var msg = ""
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        self.getStoreInfo { (message) in
            DispatchQueue.main.async {
                if message != nil {
                    status = false
                    msg = message ?? ""
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        self.getProductInfo { (message) in
            DispatchQueue.main.async {
                if message != nil{
                    status = false
                    msg = message ?? ""
                }
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            completion(status , msg)
        }
    }
}

//API integrations
extension StoreDetailViewModel {
    
    //To fetch products from server
    func getProductInfo(completionHandler : @escaping(String?)->Void, useCase : ProductRequestUseCase = ProductRequestUseCase() ) {
        
        boolLoading = true
        productRequestUseCase = useCase
        
        productRequestUseCase?.initialize(completionHandler: { [weak self] (responseDTO, error) in
            
            guard let `self` = self else { return }
            self.boolLoading = false
            
            if(error != nil) {
                
                completionHandler(error?.localizedDescription)
            } else {
                
                self.products = responseDTO
                
                if self.products?.count != nil {
                    
                    guard var products = self.products else { return }
                    
                    for id in 0..<products.count {
                        
                        products[id].isSelected = false
                        products[id].quantity = 1
                        products[id].id = id
                    }
                    self.products = products
                }
                completionHandler(nil)
            }
        })
    }
    
    //To fetch store detail from server
    func getStoreInfo(completionHandler : @escaping(String?)->Void, useCase : StoreRequestUseCase = StoreRequestUseCase() ) {
        
        boolLoading = true
        storeRequestUseCase = useCase
        
        storeRequestUseCase?.initialize(completionHandler: { [weak self] (responseDTO, error) in
            
            guard let `self` = self else { return }
            self.boolLoading = false
            
            if(error != nil) {
                
                completionHandler(error?.localizedDescription)
            } else {
                
                self.store = responseDTO
                completionHandler(nil)
            }
        })
    }
}

//Busines logic functions
extension StoreDetailViewModel {
    
    func addDataToCard() {
        
        if totalItemsInCard != 0 {
            itemsIncard = []
            itemsIncard = products?.filter { product in
                if product.quantity == nil {
                    return false
                }
                return product.quantity ?? 0 > 0 && (product.isSelected ?? false)
            } ?? []
        }
    }
    
    func updateItemCountInCart(isAdding: Bool) {
        
        isAdding ? (totalItemsInCard += 1) : (totalItemsInCard -= 1)
    }
    
    func updateItem() {
        
        guard let product = products else { return }
        
        itemsIncard = []
        for count in 0..<product.count{
            if product[count].isSelected ?? false {
                itemsIncard.append(product[count])
            }
        }
    }
    
    func populateData(_product: Product)-> Product {
        
        var product = _product
        if product.quantity != 0 {
            product.price = (product.price ?? 0) * (product.quantity ?? 1)
        }
        return product
    }
}
