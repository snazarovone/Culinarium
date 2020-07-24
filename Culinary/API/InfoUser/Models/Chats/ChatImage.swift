//
//  ChatImage.swift
//  Culinary
//
//  Created by Sergey Nazarov on 29.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class ChatImage: Mappable{
    
    var id: Int?
    var reply_id: Int?
    var path: String?
    var title: String?
    var size: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        reply_id <- map["reply_id"]
        path <- map["path"]
        title <- map["title"]
        size <- map["size"]
    }
    
}
