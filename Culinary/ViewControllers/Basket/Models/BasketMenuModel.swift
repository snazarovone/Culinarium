//
//  BasketMenuModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class BasketMenuModel: BasketModelType, DeliveryInfoModelType{
    
    var basketCellType: BasketCellType{
        return .menuItems
    }
    
    var deliveryCellType: DeliveryCellType{
        return .menu
    }
    
    var items: [String]
    
    var currentIndex = 0

    init(items: [String]){
        self.items = items
    }
    
}
