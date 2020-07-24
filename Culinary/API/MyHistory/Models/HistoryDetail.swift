//
//  HistoryDetail.swift
//  Culinary
//
//  Created by Sergey Nazarov on 23.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class HistoryDetail: Mappable{
    
    var id: Int?
    var user: UserInfo?
    var delivery_type: BasketDelivery?
    var order_time: String?
    var address: AddressInfoUser?
    var payment_type: HistoryPaymentType?
    var comment: String?
    var weight: Int?
    var portions: Int?
    var sum: Int?
    var discount: Int?
    var delivery: Int?
    var total_sum: Int?
    var status: HistoryOrderStatus?
    var items: [HistoryDetailItem]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        user <- map["user"]
        delivery_type <- map["delivery_type"]
        order_time <- map["order_time"]
        address <- map["address"]
        comment <- map["comment"]
        payment_type <- map["payment_type"]
        weight <- map["weight"]
        portions <- map["portions"]
        sum <- map["sum"]
        discount <- map["discount"]
        delivery <- map["delivery"]
        total_sum <- map["total_sum"]
        status <- map["status"]
        items <- map["items"]
    }
    
}
