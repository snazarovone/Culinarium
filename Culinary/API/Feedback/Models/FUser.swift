//
//  FUser.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class FUser: Mappable{
    
    var name: String?
    var image: String?
   
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        image <- map["image"]
    }
    
}
