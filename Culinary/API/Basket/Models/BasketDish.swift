//
//  BasketDish.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class BasketDish: Mappable{
    
    var id: Int?
    var title: String?
    var preview_image: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        preview_image <- map["preview_image"]
    }
    
    
}
