//
//  AddressCafeModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

class AddressCafeModel: AboutCafeModels{
    var nameCafe: String?
    
    var working_days: String?
    
    var open: String?
    
    var close: String?
    
    var addressCafe: String?
    
    var metroName: String?
    
    var colorCircle: String?
    
    var typeCell: AboutCafeType{
        return .addressCafe
    }
    
    init(working_days: String?, open: String?, close: String?, addressCafe: String?, metroName: String?, colorCircle: String?){
        self.working_days = working_days
        self.open = open
        self.close = close
        self.addressCafe = addressCafe
        self.metroName = metroName
        self.colorCircle = colorCircle
    }
}
