//
//  CatSectionMenu.swift
//  Culinary
//
//  Created by Sergey Nazarov on 03.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class CatSectionMenu: Mappable{
    
    var id: Int?
    var title: String?
    var section_id: Int?
    var dishes: [DisheModel]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        section_id <- map["section_id"]
        dishes <- map["dishes"]
    }
    
}
