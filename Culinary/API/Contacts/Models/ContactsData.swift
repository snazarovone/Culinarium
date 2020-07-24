//
//  ContactsData.swift
//  Culinary
//
//  Created by Sergey Nazarov on 11.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class ContactsData: Mappable {
    
    var id: Int?
    var call_center_number: String?
    var working_days: String?
    var working_hours: String?
    var contacts: [ContactValue]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        call_center_number <- map["call_center_number"]
        working_days <- map["working_days"]
        working_hours <- map["working_hours"]
        contacts <- map["contacts"]
    }
    
}
