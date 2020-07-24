//
//  StocksActionType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 08.04.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class StocksActionType: Mappable {
    
    var id: Int?
    var title: String?
    var info: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        info <- map["info"]
    }
    
    
}
