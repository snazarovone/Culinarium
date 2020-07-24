//
//  BNotForgetTableViewCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class BNotForgetTableViewCellViewModel: BNotForgetTableViewCellViewModelType{
 
    private var dataDish = [BDishNotForgotModel]()
    
    init(dataDish: [BDishNotForgotModel]){
        self.dataDish = dataDish
    }
    
    func numberOfRow() -> Int {
        return dataDish.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> BNotForgetDishCollectionViewModelType {
        return BNotForgetDishCollectionViewModel(dish: dataDish[indexPath.row])
    }
    
}
