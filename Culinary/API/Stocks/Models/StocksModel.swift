//
//  StocksModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 08.04.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class StocksModel: BaseResponseModel{
    var actions: [StocksActions]?
    var action_types: [StocksActionType]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init(success: Bool?, error: String?) {
        super.init(success: success, error: error)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        actions <- map["actions"]
        action_types <- map["action_types"]
    }
}
