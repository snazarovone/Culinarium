//
//  CurrentOrderInfo.swift
//  Culinary
//
//  Created by Sergey Nazarov on 14.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

class CurrentOrderInfo: CurrentOrder{
    var currentType: CurrentOrderType{
        return .infoOrder
    }
    
    init(){
        
    }
}
