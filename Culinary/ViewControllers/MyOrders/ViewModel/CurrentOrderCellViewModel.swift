//
//  CurrentOrderCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 21.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

class CurrentOrderCellViewModel: CurrentOrderCellViewModelType{
 
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
    
    var totalTime: Int64{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = historyOrder.order_time, let d = dateFormatter.date(from: date){
            let currentDate = Date()
            let seconds = d.timeIntervalSince1970 - currentDate.timeIntervalSince1970
            if seconds > 0{
                return Int64(seconds)
            }else{
                return 0
            }
        }else{
            return 0
        }
    }
    
    private let historyOrder: HistoryOrder
    init(historyOrder : HistoryOrder) {
        self.historyOrder = historyOrder
    }
}
