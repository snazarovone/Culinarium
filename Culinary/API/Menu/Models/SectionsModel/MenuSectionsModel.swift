//
//  MenuSectionsModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 01.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class MenuSectionsModel: BaseResponseModel{
  
    var data: [MenuSection]?
    var dataWithCat: MenuSection?
    var dataSectionWithDishes: [CatSectionMenu]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init(success: Bool?, error: String?) {
        super.init(success: success, error: error)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
        dataWithCat <- map["data"]
        dataSectionWithDishes <- map["data"]
    }
}
