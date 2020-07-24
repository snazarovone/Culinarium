//
//  NewsLetterModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 19.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class NewsLetterModel: BaseResponseModel{
    private var statusModel: Int?
    var status: NewsLetter = .notSubscribe
    
    required init(success: Bool?, error: String?) {
        super.init(success: success, error: error)
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        statusModel <- map["status"]
        if let statusModel = statusModel, statusModel == 1{
            status = .subscribe
        }else{
            status = .notSubscribe
        }
    }
}
