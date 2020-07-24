//
//  BasketExtraModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class BasketExtraModel: Mappable{
    
    var id: Int?
    var extra_id: Int?
    var order_id: Int?
    var quantity: Int?
    var extra: BasketExtra?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        extra_id <- map["extra_id"]
        order_id <- map["order_id"]
        quantity <- map["quantity"]
        extra <- map["extra"]
    }
    
}
