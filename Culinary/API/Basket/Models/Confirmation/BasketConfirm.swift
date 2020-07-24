//
//  BasketConfirm.swift
//  Culinary
//
//  Created by Sergey Nazarov on 20.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class BasketConfirm: Mappable{
    
    var id: Int?
    var total_weight: Int?
    var total_sum: Int?
    var date: String?
    var time: String?
    var delivery: BasketDelivery?
    var address: AddressInfoUser?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        total_weight <- map["total_weight"]
        total_sum <- map["total_sum"]
        date <- map["date"]
        time <- map["time"]
        delivery <- map["delivery"]
        address <- map["address"]
    }
}
