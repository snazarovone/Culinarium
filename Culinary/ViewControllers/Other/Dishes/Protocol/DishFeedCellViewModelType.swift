//
//  DishFeedCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 26.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol DishFeedCellViewModelType: class {
    var nameDish: String?{get}
    
    var imgDish: String?{get}
    
    var typeDish: String?{get}
    
    var protionDish: String?{get}
}
