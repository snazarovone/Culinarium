//
//  VKModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 22.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

class VKModel{
    
    var email: String?
    var idUser: String
    
    init(email: String?, id: String){
        self.email = email
        self.idUser = id
    }
}
