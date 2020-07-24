//
//  BasketViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 23.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BasketViewModel{
    
    private var basketModel = [BasketModelType]()
    
    private var basketDataModel: BehaviorRelay<BasketModel?> = BehaviorRelay(value: nil)
    
    
    init(basketDataModel: BehaviorRelay<BasketModel?>){
        self.basketDataModel = basketDataModel
        
        //        let menuItems = BasketMenuModel(items: ["основное меню", "экспресс-меню", "торты на заказ", "пирожки"])
        //        let gift = BasketGiftModel()
        
//
//        let fDish1 = BDishNotForgotModel(img: #imageLiteral(resourceName: "Rectangle 7 Copy 2-1"),
//                                        price: "70",
//                                        currency: "₽",
//                                        title: "Морс клюква",
//                                        count: 1)
//
//        let fDish2 = BDishNotForgotModel(img: #imageLiteral(resourceName: "Rectangle 7 Copy 2-1"),
//                                         price: "80",
//                                         currency: "₽",
//                                         title: "Морс черная смородина",
//                                         count: 0)
//
//        let notForget = BasketNotForgetModel(title: "Не забудьте напиток",
//                                             freeCount: 1,
//                                             dish: [fDish1, fDish2, fDish1, fDish2])
//        self.basketModel.append(notForget)
        
//        let couponsModel = CouponsTableCellViewModel(tabMainCellType: .tabMainCoupons, tabMainDelegate: nil)
//        self.basketModel.append(couponsModel)
        
//        let promotinal = BasketPromotionalModel()
//        self.basketModel.append(promotinal)
        
    }
    
    public func dataUpdate(){
        basketModel.removeAll()
        
        if (basketDataModel.value?.items ?? []).count > 0{
            let countDish = BasketCountDishModel()
            self.basketModel = [countDish]
        }
        
        for item in basketDataModel.value?.items ?? []{
            self.basketModel.append(BasketDishModel(basketItem: item))
        }
        
        if let extras = basketDataModel.value?.extras, extras.count > 0{
            let additionally = BasketAdditionallyModel(extras: extras)
            self.basketModel.append(additionally)
        }
        
        if (basketDataModel.value?.items ?? []).count > 0{
            let totalModel = BasketTotalModel(basketModel: basketDataModel.value!)
            self.basketModel.append(totalModel)
        }
        
    }
    
    //MARK:- Delegates
    func changeDataMenuDelegate(currentIndex: Int){
        for menuModel in basketModel{
            if menuModel.basketCellType == .menuItems{
                (menuModel as! BasketMenuModel).currentIndex = currentIndex
                return
            }
        }
    }
}

//MARK:- TableView DataSource
extension BasketViewModel: BasketViewModelType{
    
    var titleChekoutBtn: String{
        if let sum = basketDataModel.value?.sum{
            return "Оформить заказ \n на \(sum) ₽"
        }else{
            return "Оформить заказ"
        }
    }
    
    func numberOfRow(in section: Int) -> Int {
        return basketModel.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> BasketModelType {
        let model = self.basketModel[indexPath.row]
        switch model.basketCellType {
        case .menuItems:
            let m = model as! BasketMenuModel
            return BMenuTableCellViewModel(basketCellType: .menuItems, itemsMenu: m.items, currentIndex: m.currentIndex)
        case .gift:
            return BGiftCellViewModel(basketCellType: model.basketCellType)
        case .countSelectDish:
            return BCountDishViewModel(countDish: basketDataModel.value!.items!.count)
        case .dish:
            let m = model as! BasketDishModel
            return BasketDishCellViewModel(item: m.basketItem)
        case .additionally:
            let m = model as! BasketAdditionallyModel
            return BAdditCellViewModel(extras: m.extras)
        case .notForget:
            let m = model as! BasketNotForgetModel
            return BNotForgetCellViewModel(basketNotForgetModel: m)
        case .coupons:
            return model
        case .promotional:
            return BasketPromotionalCellViewModel()
        case .total:
            let m = model as! BasketTotalModel
            return BasketTotalCellViewModel(basketModel: m.basketModel)
        }
    }
    
    func remove(at indexPaht: IndexPath) -> Int? {
        let idDish = (basketModel[indexPaht.row] as! BasketDishModel).basketItem.id
        self.basketModel.remove(at: indexPaht.row)
        return idDish
    }
    
    func countDishInModel() -> Int{
        var count = 0
        for cell in self.basketModel{
            if cell.basketCellType == .dish{
                count += 1
            }
        }
        return count
    }
    
    func checkCountDish(){
        if countDishInModel() == 0{
            let menu = self.basketModel.first!
            self.basketModel.removeAll()
            self.basketModel.append(menu)
        }
    }
}
