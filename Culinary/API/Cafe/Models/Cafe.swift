//
//  Cafe.swift
//  Culinary
//
//  Created by Sergey Nazarov on 20.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class Cafe: Mappable{
   
    var id: Int?
    var title: String?
    var image: String?
    var gallery: [Gallery]?
    var description: String?
    var lat: String?
    var lng: String?
    var address: String?
    var cafe_type_id: Int?
    var working_days: String?
    var open: String?
    var close: String?
    var kitchens: [String]?
  
    private var wifi: Int?
    var isWifi: Bool = true
    private var snacks: Int?
    var isSnacks: Bool = true
    private var food_order: Int?
    var isFood_order: Bool = true
    
    var average_check: Int? //средний чек
    var phone: String?
    var distance: Int?
    var metro_station: MetroStation?
    var cafe_type: CafeType?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        image <- map["image"]
        gallery <- map["gallery"]
        description <- map["description"]
        lat <- map["lat"]
        lng <- map["lng"]
        address <- map["address"]
        cafe_type_id <- map["cafe_type_id"]
        working_days <- map["working_days"]
        open <- map["open"]
        close <- map["close"]
        kitchens <- map["kitchens"]
      
        wifi <- map["wifi"]
        if let wifi = wifi, wifi == 1{
            self.isWifi = true
        }else{
            self.isWifi = false
        }
        
        
        snacks <- map["snacks"]
        if let snacks = snacks, snacks == 1{
            self.isSnacks = true
        }else{
            self.isSnacks = false
        }
        
        food_order <- map["food_order"]
        if let food_order = food_order, food_order == 1{
            self.isFood_order = true
        }else{
            self.isFood_order = false
        }
        
        average_check <- map["average_check"]
        phone <- map["phone"]
        distance <- map["distance"]
        metro_station <- map["metro_station"]
        cafe_type <- map["cafe_type"]
    }
    
}
