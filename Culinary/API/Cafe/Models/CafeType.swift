//
//  CafeType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 20.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class CafeType: Mappable{
    
    var id: Int?
    var title: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {

    }
}
