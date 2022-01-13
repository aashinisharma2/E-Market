//
//  AppURLs.swift
//  E-Market
//
//  Created by Aashini on 12/01/22.
//

import Foundation

enum AppUrl: String {
    
    case getProducts = "https://c8d92d0a-6233-4ef7-a229-5a91deb91ea1.mock.pstmn.io/products"
    case storeDetails = "https://c8d92d0a-6233-4ef7-a229-5a91deb91ea1.mock.pstmn.io/storeInfo"
    case postOrder = "https://c8d92d0a-6233-4ef7-a229-5a91deb91ea1.mock.pstmn.io/order"
}

extension AppUrl {
    
    var value: URL {
        
        return URL(string: self.rawValue)!
    }
}

