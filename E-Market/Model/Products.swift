//
//  Products.swift
//  E-Market
//
//  Created by Aashini on 09/01/22.
//

import Foundation

struct Product : Decodable,Hashable {
    
    var id          : Int?
    var name        : String?
    var price       : Int?
    var imageUrl    : String?
    var quantity    : Int?
    var isSelected  : Bool? = false
    
    var jsonDict: [String:Any] {
        
        var dictData: [String:Any] = [:]
        
        if let name = name {
            dictData["name"] = name
        }
        if let price = price {
            dictData["price"] = "\(price * (quantity ?? 1))"
        }
        if let imageURl = imageUrl {
            dictData["imageUrl"] = imageURl
        }
        return dictData
    }
}
