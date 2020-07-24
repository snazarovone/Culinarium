//
//  BNotForgetCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BNotForgetCellViewModel: BasketModelType, BNotForgetCellViewModelType {
   
    var titleNotForget: String
    
    var countFree: String
    
    var dish: [BDishNotForgotModel]
       
    var basketCellType: BasketCellType{
        return .notForget
    }
    
    var hightCountFreeV: CGFloat{
        if cFree > 0{
            return 24.0
        }else{
            return 0.0
        }
    }
    
    private var cFree: Int
    
    init(basketNotForgetModel: BasketNotForgetModel){
        self.titleNotForget = basketNotForgetModel.title
        self.countFree = "\(basketNotForgetModel.freeCount) бесплатно"
        self.dish = basketNotForgetModel.dish
        self.cFree = basketNotForgetModel.freeCount
    }
}
