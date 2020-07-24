//
//  HeaderDishViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 22.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class HeaderDishViewModel: HeaderDishViewModelType{
    
    private var portions = [PortionsDish]()
    private var selectRow: IndexPath = IndexPath(row: 0, section: 0)
    
    init(portions: [PortionsDish], selectPortion: PortionsDish?){
        self.portions = portions
        _ = getSelectRow(at: selectPortion)
    }
    
    public func getSelectRow(at selectPortion: PortionsDish?) -> IndexPath{
        guard let selectPortion = selectPortion else{
            return IndexPath(row: 0, section: 0)
        }
        for (index, portion) in portions.enumerated(){
            if (portion.id ?? -1) == selectPortion.id{
                self.selectRow = IndexPath(row: index, section: 0)
                return self.selectRow
            }
        }
        return IndexPath(row: 0, section: 0)
    }
    
    func numberOfRow(in section: Int) -> Int {
        return portions.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> WightEatCellViewModelType {
        var select = false
        if selectRow.row == indexPath.row{
            select = true
        }
        return WightEatCellViewModel(weight: portions[indexPath.row].portion ?? 0, isSelect: select)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        self.selectRow = indexPath
    }
    
    func getPortion() -> PortionsDish{
        return portions[selectRow.row]
    }
    
    func getWightTextAt(indexPath: IndexPath) -> CGFloat {
        let font = UIFont(name:"Rubik-Regular", size:13.0)!
        var wight : CGFloat = 0.0
        
        let title = "\(self.portions[indexPath.row].portion ?? 0)"
        wight = title.width(withConstrainedHeight: 15.5, font: font) + 24
        return wight
    }
}
