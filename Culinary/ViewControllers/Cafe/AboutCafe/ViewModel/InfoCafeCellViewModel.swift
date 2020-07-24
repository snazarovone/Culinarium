//
//  InfoCafeCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

class InfoCafeCellViewModel: AboutCafeModels, InfoCafeCellViewModelType{
   
    var nameInfo: String{
        return info.name
    }
    
    var valueInfo: String{
        return info.value
    }
    
    var typeCell: AboutCafeType{
        return .infoCafe
    }
    
    private let info: InfoCafeModel
    
    init(info: InfoCafeModel){
        self.info = info
    }
}
