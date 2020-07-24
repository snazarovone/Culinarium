//
//  FeedbackUser.swift
//  Culinary
//
//  Created by Sergey Nazarov on 25.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class FeedbackUser: Mappable{
   
    var id: Int?
    var name: String?
    var surname: String?
    var patronymic: String?
    var image: String?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        surname <- map["surname"]
        patronymic <- map["patronymic"]
        image <- map["image"]
    }
}
