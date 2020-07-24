//
//  BasketDishCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class BasketDishCellViewModel: BasketModelType, BasketDishCellViewModelType{
  
    var idItemInBasket: Int?{
        return item.id
    }
        
    var urlImageDish: String?{
        return item.dish?.preview_image
    }
    
    var nameDish: String?{
        return item.dish?.title
    }
    
    var portionW: String?{
        if let w = item.portion?.portion{
            return "\(w)г."
        }else{
            return nil
        }
    }
    
    var quantity: String{
        if let q = item.quantity{
            return "\(q)"
        }else{
            return "0"
        }
    }
    
    var price: String?{
        if let sum = item.sum{
            return "\(sum)"
        }else{
            return "0"
        }
    }
    
    var currency: String?{
        return "₽"
    }
    
    var descPriceAndQuantity: String?{
        var text = ""
        if let price = item.portion?.price{
            text = "\(price) ₽"
        }
        
        if let q = item.quantity{
            if text != ""{
                text += " х \(q)шт."
            }else{
                text = "\(q)шт."
            }
        }
        return text
    }
    
   
    var basketCellType: BasketCellType{
        return .dish
    }
    
    private let item: BasketItem
    
    init(item: BasketItem){
        self.item = item
    }
}
