//
//  AboutOrderDishCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 14.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class AboutOrderDishCellViewModel: AboutOrderType, AboutOrderDishCellViewModelType{
   
    var image: String?{
        return dish.dish?.preview_image
    }
    
    var titleDish: String{
        return dish.dish?.title ?? ""
    }
    
    var weightDish: String{
        if let w = dish.portion?.portion{
            return "\(w)г."
        }
        return ""
    }
    
    var countDish: String{
        if let q = dish.quantity{
            return "\(q)шт."
        }
        return ""
    }
    
    var type: AboutOrderCellType{
        return .dishOrder
    }
    
    private let dish: HistoryDetailItem
    
    init(dish: HistoryDetailItem){
        self.dish = dish
    }
    
}
