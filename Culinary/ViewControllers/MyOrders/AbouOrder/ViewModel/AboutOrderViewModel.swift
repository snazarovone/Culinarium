//
//  AboutOrderViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 14.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

class AboutOrderViewModel{
    
    private var dataAboutOrder = [AboutOrderType]()
    private let detailOrder: HistoryDetail
    
    init(detailOrder: HistoryDetail){
        self.detailOrder = detailOrder
        let info = InfoAboutOrder(detailOrder: detailOrder)
        dataAboutOrder = [info]
        
        for item in detailOrder.items ?? []{
            dataAboutOrder.append(DishOrderModel(historyDetailItem: item))
        }
    }
    
    var position: String{
        return detailOrder.status?.title ?? ""
    }
    
    var numberOrder: String{
        if let id = detailOrder.id{
            return "Заказ № \(id)"
        }
        return "Заказ №"
    }
}

extension AboutOrderViewModel: AboutOrderViewModelType{
    func numberOfRow() -> Int {
        return dataAboutOrder.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> AboutOrderType {
        switch dataAboutOrder[indexPath.row].type {
        case .dishOrder:
            let data = dataAboutOrder[indexPath.row] as! DishOrderModel
            return AboutOrderDishCellViewModel(dish: data.historyDetailItem)
        case .infoOrder:
            return AboutOrderInfoCellViewModel(detailInfo: (dataAboutOrder[indexPath.row] as! InfoAboutOrder).detailOrder)
        }
    }
 
}
