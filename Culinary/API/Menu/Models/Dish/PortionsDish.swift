//
//  PortionsDish.swift
//  Culinary
//
//  Created by Sergey Nazarov on 03.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class PortionsDish: Mappable{
    
    var id: Int?
    var dish_id: Int?
    var portion: Int?
    var price: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        dish_id <- map["dish_id"]
        portion <- map["portion"]
        price <- map["price"]
    }
    
    
}
