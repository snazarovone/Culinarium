//
//  InfoCafeModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

class InfoCafeModel: AboutCafeModels{
    var typeCell: AboutCafeType{
        return .infoCafe
    }
    
    var name: String, value: String
    
    init(name: String, value: String?, isMake: Bool?){
        self.name = name
        
        if let value = value{
             self.value = value
        }else{
            if let isMake = isMake, isMake == true{
                self.value = "Есть"
            }else{
                self.value = "Нет"
            }
        }
        
    }
    
}
