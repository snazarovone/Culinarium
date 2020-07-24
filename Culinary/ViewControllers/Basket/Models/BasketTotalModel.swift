//
//  BasketTotalModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class BasketTotalModel: BasketModelType{
    var basketCellType: BasketCellType{
        return .total
    }
    
    public let basketModel: BasketModel
    init(basketModel: BasketModel){
        self.basketModel = basketModel
    }
}
