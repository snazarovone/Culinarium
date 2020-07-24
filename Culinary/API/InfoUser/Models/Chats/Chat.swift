//
//  Chat.swift
//  Culinary
//
//  Created by Sergey Nazarov on 29.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class Chat: Mappable{
    var id: Int?
    var user_id: Int?
    var admin_id: Int?
    var theme: String?
    var replies: [ChatReplie]?
    var image: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        user_id <- map["user_id"]
        admin_id <- map["admin_id"]
        theme <- map["theme"]
        replies <- map["replies"]
        image <- map["image"]
    }
    
}
