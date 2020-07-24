//
//  BasketModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class BasketModel: Mappable {
    
    var id: Int?
    var sum: Int?
    var weight: Int?
    var quantity: Int?
    var items: [BasketItem]?
    var extras: [BasketExtraModel]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        sum <- map["sum"]
        weight <- map["weight"]
        quantity <- map["quantity"]
        items <- map["items"]
        extras <- map["extras"]
    }
}
