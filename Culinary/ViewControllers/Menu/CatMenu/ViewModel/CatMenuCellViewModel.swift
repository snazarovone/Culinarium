//
//  CatMenuCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class CatMenuCellViewModel: CatMenuCellViewModelType{
    var imageDish: String?
    
    var badgesNew: Bool?{
        return true
    }
    
    var countInBasket: String?{
        return nil
    }
    
    var isHideInBasket: Bool?{
        if let countInBasket = countInBasket, let count = Int(countInBasket),
            count > 0{
            return false
        }else{
            return true
        }
    }
    
    var favorite: UIImage?
    
    var newPrice: String?
    
    var currency: String?{
        return "₽"
    }
    
    var oldPrice: NSAttributedString?{
        if let newPrice = newPrice, let p = Int(newPrice), p != 0, p != price{
            //перечеркиваем цену
            let attributedString = NSAttributedString(string: "\(price)", attributes:[NSAttributedString.Key.strikethroughStyle:1.0,NSAttributedString.Key.strikethroughColor:UIColor(red:0.37, green:0.347, blue:0.334, alpha:1.0),NSAttributedString.Key.font:UIFont(name:"Rubik-Regular", size:10.0)!,NSAttributedString.Key.foregroundColor:UIColor(red:0.37, green:0.347, blue:0.334, alpha:1.0)])
            return attributedString
        }
        newPrice = "\(price)"
        return nil
    }
    
    var titleDish: String?
    
    var weightDish: String?
        
    private var price = 0

    init(dish: DisheModel, selectPortion: Int){
        
        if let portions = dish.portions{
            for (i, portion) in portions.enumerated(){
                if i == selectPortion{
                    self.price = portion.price ?? 0
                    if let p = portion.portion{
                        self.weightDish = "\(p)"
                    }else{
                       self.weightDish = nil
                    }
                    break
                }
            }
        }
        let discont = dish.discount ?? 0
        newPrice = String(self.price - Int((self.price * discont) / 100))
        
        
        self.imageDish = dish.preview_image
        self.titleDish = dish.title
        
        switch dish.wishlist {
        case .favorite:
            self.favorite = UIImage(named: "ic_favorites_red")
        case .unFavorite:
            self.favorite = UIImage(named: "ic_favorites_unselect")
        }
    }
}
