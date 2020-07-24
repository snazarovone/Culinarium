//
//  FilterCafe.swift
//  Culinary
//
//  Created by Sergey Nazarov on 20.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class FilterCafe: Mappable, Copying{
    
    var id: Int?
    var title: String?
    var values: [FilterCafeValue]?
    var collapsed: Bool = false
    var typeFilter: TypeFilter?
    
    required init?(map: Map) {
    }
    
    required init(original: FilterCafe) {
        id = original.id
        title = original.title
        values = original.values?.clone()
        collapsed = original.collapsed
        typeFilter = original.typeFilter
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        values <- map["values"]
        
        for type in TypeFilter.allCases{
            if type.id == id{
                typeFilter = type
                break
            }
        }
    }
    
}
