//
//  BasketExtra.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class BasketExtra: Mappable{
    
    var id: Int?
    var title: String?
    var price: Int?
    var weight: Int?
 
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        price <- map["price"]
        weight <- map["weight"]
    }
    
}
