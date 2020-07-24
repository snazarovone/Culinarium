//
//  FeedbackCafeImage.swift
//  Culinary
//
//  Created by Sergey Nazarov on 25.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class FeedbackCafeImage: Mappable{
   
    var id: Int?
    var review_id: Int?
    var path: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        review_id <- map["review_id"]
        path <- map["path"]
    }
    
}
