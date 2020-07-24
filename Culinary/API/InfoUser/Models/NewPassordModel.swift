//
//  NewPassordModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 18.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class NewPassordModel: BaseResponseModel{
    var message: String?
    
    required init(success: Bool?, error: String?) {
        super.init(success: success, error: error)
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        message <- map["message"]
    }
}
