//
//  ContactValue.swift
//  Culinary
//
//  Created by Sergey Nazarov on 11.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class ContactValue: Mappable{
    
    var id: Int?
    var name: String?
    var description: String?
    var email: String?
    var phone: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
        email <- map["email"]
        phone <- map["phone"]
    }

}
