//
//  DishMainInfo.swift
//  Culinary
//
//  Created by Sergey Nazarov on 28.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class DishMainInfo: Mappable{
    var id: Int?
    var title: String?
    var preview_image: String?
    var category_id: Int?
    var section_id: Int?
    var section: DishMainInfoSection?
    var category: DishMainInfoCategory?
    var portions: [PortionsDish]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        preview_image <- map["preview_image"]
        category_id <- map["category_id"]
        section_id <- map["section_id"]
        section <- map["section"]
        category <- map["category"]
        portions <- map["portions"]
    }
    
}
