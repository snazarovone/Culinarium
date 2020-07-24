//
//  CouponsModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 09.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class CouponsModel: CouponsModelType{
  
    var typeCell: CouponsCellType
    var timeView: Bool
    
    init(typeCell: CouponsCellType, timeView: Bool){
        self.typeCell = typeCell
        self.timeView = timeView
    }
    
}
