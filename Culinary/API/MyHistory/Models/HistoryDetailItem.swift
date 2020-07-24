//
//  HistoryDetailItem.swift
//  Culinary
//
//  Created by Sergey Nazarov on 23.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class HistoryDetailItem: Mappable{
    
    var dish: DisheModel?
    var portion: PortionsDish?
    var quantity: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        dish <- map["dish"]
        portion <- map["portion"]
        quantity <- map["quantity"]
    }
    
    
}
