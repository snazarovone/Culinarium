//
//  Gallery.swift
//  Culinary
//
//  Created by Sergey Nazarov on 15.06.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class Gallery: Mappable {
    var id, cafeID: Int?
    var image: String?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        cafeID <- map["cafeID"]
        image <- map["image"]
    }
}
