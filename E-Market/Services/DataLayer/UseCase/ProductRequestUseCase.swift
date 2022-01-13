//
//  ProductCollectionRequestUseCase.swift
//  E-Market
//
//  Created by Aashini on 10/01/22.
//

import UIKit

struct ProductResponseDTO : Decodable {
    var products : [Product]?
}

class ProductRequestUseCase: BaseRequestUseCase<[Product]> {
    
    var sessionTask : URLSessionTask?
    
    func initialize(completionHandler:@escaping([Product]?,Error?)->Void) {
        
        let baseUrl = AppUrl.getProducts.value
        sessionTask?.cancel()
        sessionTask = super.getDataFromServerUsingGet(url:baseUrl, completionHandler: completionHandler)
    }
    
    override func decode(data: Data) throws -> [Product] {
        
        let decoder = JSONDecoder()
        return try decoder.decode([Product].self, from: data)
    }
}

