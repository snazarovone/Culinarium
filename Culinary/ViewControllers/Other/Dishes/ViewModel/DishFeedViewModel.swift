//
//  DishFeedViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 28.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DishFeedViewModel: DishFeedViewModelType{
    
    private var dishesMainInfo: BehaviorRelay<[DishMainInfo]> = BehaviorRelay(value: [])
    
    init(dishesMainInfo: BehaviorRelay<[DishMainInfo]>){
        self.dishesMainInfo = dishesMainInfo
    }
    
    func numberForRaw() -> Int {
        return dishesMainInfo.value.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> DishFeedCellViewModelType {
        return DishFeedCellViewModel(dish: dishesMainInfo.value[indexPath.row])
    }
    
    func didSelectRow(at indexPath: IndexPath) -> Int? {
        return dishesMainInfo.value[indexPath.row].id
    }
    
    func dishes() -> BehaviorRelay<[DishMainInfo]>{
        return dishesMainInfo
    }
    
}
