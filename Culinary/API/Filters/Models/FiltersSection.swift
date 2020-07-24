//
//  FiltersSection.swift
//  Culinary
//
//  Created by Sergey Nazarov on 08.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class FiltersSection: Mappable, Copying{
    
    var id: Int?
    var title: String?
    var section_id: Int?
    var values: [FiltersSectionValues]?
    var collapsed: Bool = false
    
    required init?(map: Map) {
    }
    
    required init(original: FiltersSection) {
        id = original.id
        title = original.title
        section_id = original.section_id
        values = original.values?.clone()
        collapsed = original.collapsed
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        section_id <- map["section_id"]
        values <- map["values"]
    }
    
}
