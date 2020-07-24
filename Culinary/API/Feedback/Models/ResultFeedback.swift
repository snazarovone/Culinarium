//
//  ResultFeedback.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class ResultFeedback: BaseResponseModel{
    var message: String?
   
   required init?(map: Map) {
       super.init(map: map)
   }
   
   required init(success: Bool?, error: String?) {
       super.init(success: success, error: error)
   }
   
   override func mapping(map: Map) {
       super.mapping(map: map)
       message <- map["message"]
   }
}
