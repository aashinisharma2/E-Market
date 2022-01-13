//
//  StoreRequestUseCase.swift
//  E-Market
//
//  Created by Aashini on 10/01/22.
//

import Foundation


struct StoreResponseDTO : Decodable{
    var store : Store?
}

class StoreRequestUseCase: BaseRequestUseCase<Store> {
    
    var sessionTask : URLSessionTask?
    
    func initialize(completionHandler:@escaping(Store?,Error?)->Void) {
        
        let baseUrl = AppUrl.storeDetails.value
        sessionTask?.cancel()
        sessionTask = super.getDataFromServerUsingGet(url: baseUrl, completionHandler: completionHandler)
    }
    
    override func decode(data: Data) throws -> Store {
        
        let decoder = JSONDecoder()
        return try decoder.decode(Store.self, from: data)
    }
}
