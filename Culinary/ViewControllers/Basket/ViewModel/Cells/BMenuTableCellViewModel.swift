//
//  BMenuTableCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 23.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class BMenuTableCellViewModel: BasketModelType, DeliveryInfoModelType, BMenuTableCellViewModelType{
   
    var deliveryCellType: DeliveryCellType{
        return .menu
    }
    
    var basketCellType: BasketCellType
    
    var itemsMenu: [String]
    
    var currentIndex: IndexPath?
    
    init(basketCellType: BasketCellType, itemsMenu: [String], currentIndex: Int){
        self.basketCellType = basketCellType
        self.itemsMenu = itemsMenu
        self.currentIndex = IndexPath(row: currentIndex, section: 0)
    }
}
