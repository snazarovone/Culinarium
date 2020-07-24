//
//  DishFeedCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 28.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

class DishFeedCellViewModel: DishFeedCellViewModelType{
  
    var nameDish: String?{
        return dish.title?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var imgDish: String?{
        return dish.preview_image
    }
    
    var typeDish: String?{
        if let titleSection = dish.section?.title, titleSection.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 {
            if let catTitle  = dish.category?.title, catTitle.trimmingCharacters(in: .whitespacesAndNewlines).count > 0{
                return "\(titleSection), \(catTitle)"
            }else{
                return "\(titleSection)"
            }
        }else{
            if let catTitle  = dish.category?.title, catTitle.trimmingCharacters(in: .whitespacesAndNewlines).count > 0{
                return "\(catTitle)"
            }else{
                return ""
            }
        }
    }
    
    var protionDish: String?{
        if let portion = dish.portions?.first?.portion{
            return "1 порция (\(portion)г.)"
        }else{
            return "1 порция"
        }
    }
    
    private let dish: DishMainInfo
  
    init(dish: DishMainInfo){
        self.dish = dish
    }
}
