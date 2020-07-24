//
//  HistOrderCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 14.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class HistOrderCellViewModel: HistOrderCellViewModelType{
    
    var id: Int?{
        return historyOrder.id
    }
    
    var numberOrder: String?{
        if let id = historyOrder.id{
            return "Заказ № \(id)"
        }
        return "Заказ"
    }
    
    var position: String?{
        if let title = historyOrder.status?.title{
            return "(\(title.uppercased()))"
        }
        return ""
    }
    
    var createDate: String?{
        return historyOrder.created_at ?? " "
    }
    
    var deliveryDate: String?{
        return historyOrder.order_time ?? " "
    }
    
    var payment: String?{
        return historyOrder.payment_type?.title ?? " "
    }
    
    var price: String?{
        if let sum = historyOrder.total_sum{
            return "\(sum)"
        }else{
            return ""
        }
    }
    
    var backgroundViewColor: UIColor
    
    private let historyOrder: HistoryOrder
    
    init(ofRow number: Int, historyOrder : HistoryOrder){
        if (number % 2 == 0){
            backgroundViewColor = UIColor(named: "Main") ?? UIColor.white
        }else{
            backgroundViewColor = UIColor.white
        }
        
        self.historyOrder = historyOrder
    }
}
