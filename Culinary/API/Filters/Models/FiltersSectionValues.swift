//
//  FiltersSectionValues.swift
//  Culinary
//
//  Created by Sergey Nazarov on 08.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class FiltersSectionValues: Mappable, Copying{

    var id: Int?
    var filter_id: Int?
    var value: String?
    var isSelect: Bool = false
    
    required init?(map: Map) {
    }
    
    required init(original: FiltersSectionValues) {
        id = original.id
        filter_id = original.filter_id
        value = original.value
        isSelect = original.isSelect
    }
         
    func mapping(map: Map) {
        id <- map["id"]
        filter_id <- map["filter_id"]
        value <- map["value"]
    }
    
}
