//
//  BasketDishModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class BasketDishModel: BasketModelType {
 
    var basketCellType: BasketCellType{
        return .dish
    }
    
    public let basketItem: BasketItem
    
    init(basketItem: BasketItem) {
        self.basketItem = basketItem
    }
}
