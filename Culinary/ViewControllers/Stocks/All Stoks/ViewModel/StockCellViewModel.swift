//
//  StockCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class StockCellViewModel: StockCellViewModelType {
    var id: Int?{
        return stock?.id
    }
    
    var coupon_code: String?{
        return stock?.coupon_code
    }
    
    var image: String?{
        return stock?.image
    }
    
    var titleStock: String?{
        return stock?.title
    }
    
    var date_end: Date?{
        if let dTime = stock?.date_end{
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = .current
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let date = dateFormatter.date(from: dTime){
                return date
            }
        }
        return nil
    }
    
    var description: String?{
        return stock?.description
    }
    
    var titleVC: String{
        return stocksAllType.title
    }
    
    private let stock: StocksActions?
    private let stocksAllType: StocksAllType
    
    init(stocksAllType: StocksAllType, stock: StocksActions?){
        self.stocksAllType = stocksAllType
        self.stock = stock
    }
}
