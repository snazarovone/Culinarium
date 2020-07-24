//
//  MetroStation.swift
//  Culinary
//
//  Created by Sergey Nazarov on 20.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class MetroStation: Mappable{
    
    var id: Int?
    var metro_line_id: Int?
    var title: String?
    var metro_line: MetroLine?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        metro_line_id <- map["metro_line_id"]
        title <- map["title"]
        metro_line <- map["metro_line"]
    }
}
