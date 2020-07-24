//
//  ChatReplie.swift
//  Culinary
//
//  Created by Sergey Nazarov on 29.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class ChatReplie: Mappable{
    
    var id: Int?
    var conversation_id: Int?
    var reply: String?
    var user_id: Int?
    private var statusValue: Int?
    var status: MessageStatus = .unread
    var date: String?
    var time: String?
    var user: UserInfo?
    var images: [ChatImage]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        conversation_id <- map["conversation_id"]
        reply <- map["reply"]
        user_id <- map["user_id"]
        statusValue <- map["status"]
        date <- map["date"]
        time <- map["time"]
        user <- map["user"]
        images <- map["images"]
        
        if let statusValue = statusValue, statusValue == 1{
            status = .read
        }else{
            status = .unread
        }
    }
    
}
