//
//  BasketItem.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class BasketItem: Mappable{
    
    
    var id: Int?
    var quantity: Int?
    var sum: Int?
    var dish: BasketDish?
    var portion: PortionsDish?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        quantity <- map["quantity"]
        sum <- map["sum"]
        dish <- map["dish"]
        portion <- map["portion"]
    }
    
    
}
