//
//  MenuSection.swift
//  Culinary
//
//  Created by Sergey Nazarov on 01.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class MenuSection: Mappable{
   
    var id: Int?
    var title: String?
    var description: String?
    var image: String?
    private var left: Int?
    var position: PositionMenu = .left
    var categories: [CatSectionMenu]?
    private var colorSection: String?
    var color: UIColor = .orange
    var filters: [FiltersSection]?
    var dishes: [DisheModel]?
    var isAllCat: Bool = false
  
    
    required init?(map: Map) {
    }
    
    init(title: String, dishes: [DisheModel]){
        self.isAllCat = true
        self.dishes = dishes
        self.title = title
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        description <- map["description"]
        image <- map["image"]
        left <- map["left"]
        categories <- map["categories"]
        colorSection <- map["color"]
        filters <- map["filters"]
        dishes <- map["dishes"]
        
        if let colorSection = colorSection{
            self.color = colorSection.hexStringToUIColor
        }
      
        if let left = left, left == 1{
            position = .left
        }else{
            position = .right
        }
        
        
    }
    
}
