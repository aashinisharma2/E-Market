//
//  ProductCollectionRequestUseCase.swift
//  Ecommerce
//
//  Created by Aashini Sharma on 10/01/22.
//

import UIKit

struct ProductResponseDTO : Decodable{
    var products : [Product]?
}

class ProductRequestUseCase: BaseRequestUseCase<[Product]> {
    
     var sessionTask : URLSessionTask?
    
    func initialize(completionHandler:@escaping([Product]?,Error?)->Void) {
        let baseUrl = "https://c8d92d0a-6233-4ef7-a229-5a91deb91ea1.mock.pstmn.io/products"
        sessionTask?.cancel()
        sessionTask = super.getDataFromServerUsingGet(url: URL(string: baseUrl)!, completionHandler: completionHandler)
    }
    
    override func decode(data: Data) throws -> [Product] {
        let decoder = JSONDecoder()
        return try decoder.decode([Product].self, from: data)
    }
}

