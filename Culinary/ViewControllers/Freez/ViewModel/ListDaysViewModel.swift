//
//  ListDaysViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 11.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class ListDaysViewModel: ListDaysViewModelType{
    
    private var daysModel: [DaysModel]
    var selectIndex: IndexPath
    
    init(daysModel: [DaysModel], selectIndex: IndexPath){
        self.daysModel = daysModel
        self.selectIndex = selectIndex
    }
    
    
    func numberOfRow(in section: Int) -> Int {
        return daysModel.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> DaysModel {
        return daysModel[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        self.selectIndex = indexPath
    }
}
