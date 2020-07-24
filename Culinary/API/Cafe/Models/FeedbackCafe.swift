//
//  FeedbackCafe.swift
//  Culinary
//
//  Created by Sergey Nazarov on 25.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class FeedbackCafe: Mappable{
    
    var id: Int?
    var cafe_id: Int?
    var date: String?
    var strengths: String?
    var weaknesses: String?
    var text: String?
    var rating: Int?
    var user: FeedbackUser?
    var images: [FeedbackCafeImage]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        cafe_id <- map["cafe_id"]
        date <- map["date"]
        strengths <- map["strengths"]
        weaknesses <- map["weaknesses"]
        text <- map["text"]
        rating <- map["rating"]
        user <- map["user"]
        images <- map["images"]
    }
    
}
