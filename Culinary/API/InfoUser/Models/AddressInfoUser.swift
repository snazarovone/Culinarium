//
//  AddressInfoUser.swift
//  Culinary
//
//  Created by Sergey Nazarov on 15.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class AddressInfoUser: Mappable{
    var id: Int?
    var title: String?
    var city: String?
    var street: String?
    var house: String? // дом
    var porch: String? //подъезд
    var flat: String? //квартира
    var floor: Int? // Этаж
    var door_code: String? // Код дома
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        city <- map["city"]
        street <- map["street"]
        house <- map["house"]
        porch <- map["porch"]
        flat <- map["flat"]
        floor <- map["floor"]
        door_code <- map["door_code"]
    }
    
}
