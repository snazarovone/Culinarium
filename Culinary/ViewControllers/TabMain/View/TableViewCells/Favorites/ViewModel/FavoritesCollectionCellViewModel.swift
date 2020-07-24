//
//  FavoritesCollectionCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class FavoritesCollectionCellViewModel: FavoritesCollectionCellViewModelType{
    var imageDish: String?
    
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
    
    var cellSize: CGSize
    
    private var price = 0
    
    init(dish: DisheModel?){
        self.cellSize = CGSize(width: 128.0, height: 196)
        self.imageDish = dish?.preview_image
        self.titleDish = dish?.title
        
        self.price = dish?.portions?.first?.price ?? 0
        let discont = dish?.discount ?? 0
        self.newPrice = String(self.price - Int((self.price * discont) / 100))
        
    }
}
