//
//  FilterCafeValue.swift
//  Culinary
//
//  Created by Sergey Nazarov on 20.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class FilterCafeValue: Mappable, Copying {
    
    var id: Int?
    var filter_id: Int?
    var value: String?
    var value_type: String?
    var isSelect: Bool = false
    
    required init?(map: Map) {
    }
    
    required init(original: FilterCafeValue) {
        id = original.id
        filter_id = original.filter_id
        value = original.value
        value_type = original.value_type
        isSelect = original.isSelect
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        filter_id <- map["filter_id"]
        value <- map["value"]
        value_type <- map["value_type"]
    }
}
