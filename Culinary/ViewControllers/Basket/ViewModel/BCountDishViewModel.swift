//
//  BCountDishViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class BCountDishViewModel: BasketModelType, BCountDishViewModelType{
   
    var countDish: String
    
    var basketCellType: BasketCellType{
        return .countSelectDish
    }
    
    init(countDish: Int){
        self.countDish = "Всего в вашей корзине \(countDish.product())"
    }
}
