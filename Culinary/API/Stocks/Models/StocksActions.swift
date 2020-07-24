//
//  StocksActions.swift
//  Culinary
//
//  Created by Sergey Nazarov on 08.04.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class StocksActions: Mappable{
    
    var id: Int?
    var uid: String?
    var title: String?
    var action_type_id: Int?
    var created_at: String?
    var updated_at: String?
    var date_start: String?
    var date_end: String?
    var image: String?
    var url: String?
    var description: String?
    var discount_percentage: Int?
    var discount_amount: Int?
    var coupon_code: String?
    var min_items: Int?
    var action_type: StocksActionType?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        uid <- map["uid"]
        title <- map["title"]
        action_type_id <- map["action_type_id"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        date_start <- map["date_start"]
        date_end <- map["date_end"]
        image <- map["image"]
        url <- map["url"]
        description <- map["description"]
        discount_percentage <- map["discount_percentage"]
        discount_amount <- map["discount_amount"]
        coupon_code <- map["coupon_code"]
        min_items <- map["min_items"]
        action_type <- map["action_type"]
    }
    
}
