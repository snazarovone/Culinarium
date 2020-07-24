//
//  BasketTotalCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class BasketTotalCellViewModel: BasketModelType, BasketTotalCellViewModelType{
  
    var wight: String?{
        if let w = basketModel.weight{
            return "\(w) гр."
        }
        return nil
    }
    
    var count: String?{
        if let p = basketModel.quantity{
            return p.portions()
        }
        return nil
    }
    
    var price: String?{
        if let sum = basketModel.sum{
            return "\(sum) ₽"
        }
        return nil
    }
    
    var allPrice: String?{
        if let sum = basketModel.sum{
            return "\(sum) ₽"
        }
        return nil
    }
    
    var total: String?{
        if let sum = basketModel.sum{
            return "\(sum)"
        }
        return nil
    }
    
    var currencyTotal: String?{
        return "₽"
    }
    
 
    var basketCellType: BasketCellType{
        return .total
    }
    
    private let basketModel: BasketModel
    
    init(basketModel: BasketModel){
        self.basketModel = basketModel
    }
    
    
}
