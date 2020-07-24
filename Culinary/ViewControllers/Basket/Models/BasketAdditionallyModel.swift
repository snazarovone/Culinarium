//
//  BasketAdditionallyModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class BasketAdditionallyModel: BasketModelType{
    var basketCellType: BasketCellType{
        return .additionally
    }
    
    
    public let extras: [BasketExtraModel]
    
    init(extras: [BasketExtraModel]){
        self.extras = extras
    }
}
