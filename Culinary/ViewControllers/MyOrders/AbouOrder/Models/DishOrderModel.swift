//
//  DishOrderModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 14.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class DishOrderModel: AboutOrderType{
    var type: AboutOrderCellType{
        return .dishOrder
    }
    
    public let historyDetailItem: HistoryDetailItem
    init(historyDetailItem: HistoryDetailItem){
        self.historyDetailItem = historyDetailItem
    }
}
