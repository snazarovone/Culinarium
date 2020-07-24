//
//  BasketCheckout.swift
//  Culinary
//
//  Created by Sergey Nazarov on 17.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class BasketCheckout: Mappable{
    
    var id: Int?
    var sum: Int?
    var weight: Int?
    var portions: Int?
    var delivery: Int?
    var discount: Int?
    var total_sum: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        sum <- map["sum"]
        weight <- map["weight"]
        portions <- map["portions"]
        delivery <- map["delivery"]
        discount <- map["discount"]
        total_sum <- map["total_sum"]
    }
    
}
