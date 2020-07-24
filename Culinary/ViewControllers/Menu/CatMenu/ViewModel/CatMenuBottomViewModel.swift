//
//  CatMenuBottomViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import UIKit

class CatMenuBottomViewModel{
    
    private var dishes = [DisheModel]()
    private var dishesFilters = [DisheModel]()
    private let delegate = UIApplication.shared.delegate as! AppDelegate
    private var auth: ErrorAuth? = nil
    
    var cash_payment: QuickFilters = .not_cash_payment
    var express_delivery: QuickFilters = .not_express_delivery
    var discount: QuickFilters = .not_discount
    let sectionId: Int
    
    init(dishes: [DisheModel], sectionId: Int){
        self.dishes = dishes
        self.dishesFilters = dishes
        self.sectionId = sectionId
    }
    
    func dishesAtQuickFilters(){
        dishesFilters.removeAll()

        if cash_payment == .not_cash_payment && express_delivery == .not_express_delivery && discount == .not_discount{
            dishesFilters = dishes
            return
        }
        
        for dish in dishes{
            if cash_payment == .cash_payment && dish.cash_payment == .cash_payment{
                dishesFilters.append(dish)
            }else{
                if express_delivery == .express_delivery && dish.express_delivery == .express_delivery{
                    dishesFilters.append(dish)
                }else{
                    if discount == .discount && dish.discountFilter == .discount{
                         dishesFilters.append(dish)
                    }
                }
            }
        }
    }
    
    func updateDishes(favorites: MenuSectionsModel){
        for dish in self.dishes{
            var isFound = false
            if let dID = dish.id{
                for fav in favorites.data ?? []{
                     for fDish in fav.dishes ?? []{
                        if let id = fDish.id, dID == id{
                            dish.wishlist = .favorite
                            isFound = true
                        }
                    }
                }
            }
            if isFound == false{
                dish.wishlist = .unFavorite
            }
        }
    }
    
    func getAuth() -> ErrorAuth? {
        return self.auth
    }
}

extension CatMenuBottomViewModel: CatMenuBottomViewModelType{
    func numberOfRow() -> Int {
        return dishesFilters.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> CatMenuCellViewModelType {
        return CatMenuCellViewModel(dish: dishesFilters[indexPath.row], selectPortion: 0)
    }
    
    func getDish(at indexPath: IndexPath) -> DisheModel? {
        if indexPath.row < self.dishesFilters.count{
            return self.dishesFilters[indexPath.row]
        }else{
            return nil
        }
    }
}

extension CatMenuBottomViewModel: SectionQuickFiltersViewModelType{
    func cellForRow() -> SectionQuickFilterCellViewModelType {
        return SectionQuickFilterCellViewModel(cash_payment: cash_payment, express_delivery: express_delivery, discount: discount)
    }
}
