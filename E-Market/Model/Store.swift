//
//  Store.swift
//  E-Market
//
//  Created by Aashini on 10/01/22.
//

import Foundation

struct Store : Decodable {
    
    var name        : String?
    var rating      : Double?
    var openingTime : String?
    var closingTime : String?
}
