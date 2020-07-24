//
//  BasketNotForgetModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class BasketNotForgetModel: BasketModelType {
    var basketCellType: BasketCellType{
        return .notForget
    }
    
    let title: String, freeCount: Int
    var dish = [BDishNotForgotModel]()
    
    init(title: String, freeCount: Int, dish: [BDishNotForgotModel]){
        self.title = title
        self.freeCount = freeCount
        self.dish = dish
    }
}
