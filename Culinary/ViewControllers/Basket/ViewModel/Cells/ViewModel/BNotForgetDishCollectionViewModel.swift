//
//  BNotForgetDishCollectionViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BNotForgetDishCollectionViewModel: BNotForgetDishCollectionViewModelType{
   
    var img: UIImage?
    
    var price: String?
    
    var currency: String?
    
    var titleDish: String?
    
    var countDishStep: String
    
    var countStepViewIsHide: Bool{
        if self.dCount > 0{
            return false
        }else{
            return true
        }
    }
    
    var addBasketIsHide: Bool{
        if dCount == 0{
            return false
        }else{
            return true
        }
    }
    
    private var dCount: Int = 0
    
    init(dish: BDishNotForgotModel){
        self.img = dish.img
        self.price = dish.price
        self.currency = dish.currency
        self.titleDish = dish.title
        self.countDishStep = "\(dish.count ?? 0)"
        self.dCount = dish.count ?? 0
    }
}
