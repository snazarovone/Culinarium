//
//  FeedUser.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class FeedUser: Mappable{
    
    var id: Int?
    var caption: String?
    var text: String?
    var created_at: String?
    var rating: Int?
    var user: FUser?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        caption <- map["caption"]
        text <- map["text"]
        created_at <- map["created_at"]
        rating <- map["rating"]
        user <- map["user"]
    }
}
