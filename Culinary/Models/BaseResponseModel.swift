//
//  BaseResponseModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 31.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseResponseModel: Mappable{
    var success: Bool?
    var error: String?
    
    required init?(map: Map) {
    }
    
    required init(success: Bool?, error: String?){
        self.success = success
        self.error = error
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        error <- map["error"]
    }
    
}
