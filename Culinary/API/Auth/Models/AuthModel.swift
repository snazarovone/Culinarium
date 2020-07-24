//
//  AuthModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 31.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class AuthModel: BaseResponseModel{
    var tokenAccess: String?
    var message: String?
    
    required init(success: Bool?, error: String?) {
        super.init(success: success, error: error)
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        tokenAccess <- map["tokenAccess"]
        message <- map["message"]
    }
}
