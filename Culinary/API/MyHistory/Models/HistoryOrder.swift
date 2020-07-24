//
//  HistoryOrder.swift
//  Culinary
//
//  Created by Sergey Nazarov on 20.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class HistoryOrder: Mappable {
    
    var id: Int? //number order
    var created_at: String? // "2020-03-17 17:14:26", //создан
    var order_time: String? // "2020-03-17 18:14:26", // доставлен(ожидается)
    var total_sum: Int?
    var status: HistoryOrderStatus?
    var payment_type: HistoryPaymentType?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        created_at <- map["created_at"]
        order_time <- map["order_time"]
        total_sum <- map["total_sum"]
        status <- map["status"]
        payment_type <- map["payment_type"]
    }
    
}
