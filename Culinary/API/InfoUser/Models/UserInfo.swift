//
//  UserInfo.swift
//  Culinary
//
//  Created by Sergey Nazarov on 18.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import ObjectMapper

class UserInfo: Mappable{
    
    var id: Int?
    var name: String?
    var surname: String?
    var patronymic: String?
    var birth_date: String?
    private var genderModel: Int?
    var gender: GenderModel = .man
    var email: String?
    var phone: String?
    var image: String?
    var email_verified_at: String?
    var created_at: String?
    var updated_at: String?
    
    required init?(map: Map) {
    }
    
    init(){
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        surname <- map["surname"]
        patronymic <- map["patronymic"]
        birth_date <- map["birth_date"]
        genderModel <- map["gender"]
        email <- map["email"]
        phone <- map["phone"]
        image <- map["image"]
        email_verified_at <- map["email_verified_at"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        
        if let genderModel = genderModel, genderModel == 0{
            self.gender = .women
        }else{
            self.gender = .man
        }
    }
    
}
