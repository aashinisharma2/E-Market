//
//  StoreDetailViewModel.swift
//  E-Market
//
//  Created by Aashini Sharma on 09/01/22.
//

import Foundation

class StoreDetailViewModel {
    
    private var requestUseCase :ProductRequestUseCase?
    var boolLoading : Bool = false
    var products : [Product]?
    
    func getProductInfo(completionHandler : @escaping(String?)->Void ,useCase : ProductRequestUseCase = ProductRequestUseCase() ) {
        boolLoading = true
        requestUseCase = useCase
        requestUseCase?.initialize(completionHandler: { (responseDTO, error) in
            self.boolLoading = false
            if(error != nil)
            {
                completionHandler(error.debugDescription)
            }else
            {
                self.products = responseDTO
                completionHandler(nil)
            }
        })
    }
}
