//
//  SocialNetwork.swift
//  Culinary
//
//  Created by Sergey Nazarov on 12.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class SocialNetwork: Mappable{
    
    var id: Int?
    var provider_id: String?
    var provider_name: String?
    var user_id: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        provider_id <- map["provider_id"]
        provider_name <- map["provider_name"]
        user_id <- map["user_id"]
    }
    
}
