//
//  DeliveryInfoViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 08.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

class DeliveryInfoViewModel{
    
    private var deliveryInfo = [DeliveryInfoModelType]()
    
    init(){
    
        let menuItems = BasketMenuModel(items: ["основное меню", "экспресс-меню", "торты на заказ", "пирожки"])
        
        let d1 = DeliveryInfo1Line(img: #imageLiteral(resourceName: "ic_minSum"), title: "Минимальная сумма", description1Line: "1000 ₽")
        
        let d2 = DeliveryInfo1Line(img: #imageLiteral(resourceName: "Basket"), title: "Оформление закaазов", description1Line: "с 09:00 до 20:00")
        
        let d3 = DeliveryInfo2Line2Col(img: #imageLiteral(resourceName: "ic_cost"), title: "Стоимость доставки", description1Line1Col: "В пределах МКАД", description1Line2Col: "Бесплатно", description2Line1Col: "За МКАД", description2Line2Col: "За МКАД")
        
        let d4 = DeliveryInfo2Line(img: #imageLiteral(resourceName: "ic_pay"), title: "Способ оплаты", description1Line: "Наличными курьеру", description2Line: "Банковской картой на сайте")
        
        let d5 = DeliveryInfo1Line(img: #imageLiteral(resourceName: "ic_delivery"), title: "Доставка", description1Line: "с 10:00 до 21:00")

        deliveryInfo = [menuItems, d1, d2, d3, d4, d5]
        
    }
}

//MARK:- TableView
extension DeliveryInfoViewModel: DeliveryInfoViewModelType{
    func cellForRow(at indexPath: IndexPath) -> DeliveryInfoModelType {
        let model = self.deliveryInfo[indexPath.row]
        
        switch model.deliveryCellType {
        case .menu:
            let m = model as! BasketMenuModel
            return BMenuTableCellViewModel(basketCellType: .menuItems, itemsMenu: m.items, currentIndex: m.currentIndex)
        case .description1Line:
            let m = model as! DeliveryInfo1Line
            return DeliveryInfoCellViewModel(deliveryInfo1Line: m)
        case .description2Line:
            let m = model as! DeliveryInfo2Line
            return DeliveryInfoCellViewModel(deliveryInfo2Line: m)
        case .description2Line2Col:
            let m = model as! DeliveryInfo2Line2Col
            return DeliveryInfoCellViewModel(deliveryInfo2Line2Col: m)
        }
    }
    
    func numberRow(of section: Int) -> Int {
        return deliveryInfo.count
    }
    
    //MARK:- Delegates
       func changeDataMenuDelegate(currentIndex: Int){
           for menuModel in deliveryInfo{
            if menuModel.deliveryCellType == .menu{
                   (menuModel as! BasketMenuModel).currentIndex = currentIndex
                   return
               }
           }
       }
    
}
