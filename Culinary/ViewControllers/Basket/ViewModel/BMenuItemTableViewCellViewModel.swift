//
//  BMenuItemTableViewCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 23.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BMenuItemTableViewCellViewModel: BMenuItemTableViewCellViewModelType{
    
    private var itemsMenu: [String]
    var selectIndexPath = IndexPath(row: 0, section: 0)
    
    init(itemsMenu: [String], selectIndexPath: IndexPath) {
        self.itemsMenu = itemsMenu
        self.selectIndexPath = selectIndexPath
    }
    
    
    func numberOfRow() -> Int {
        return itemsMenu.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> BMenuCollectionCellViewModelType {
        var select = false
        if selectIndexPath.row == indexPath.row{
            select = true
        }
        return BMenuCollectionCellViewModel(item: itemsMenu[indexPath.row], isSelect: select, indexPath: indexPath, basketCellType: .menuItems)
    }
    
    func didSelect(at indexPath: IndexPath) {
        self.selectIndexPath = indexPath
    }
    
    func getWightTextAt(indexPath: IndexPath) -> CGFloat {
        let font = UIFont(name:"Rubik-Medium", size:14.0)!
        var wight : CGFloat = 0.0
        
        let title = self.itemsMenu[indexPath.row]
        let words = title.split(separator: " ")
        if words.count > 1 || title.contains("-"){
            wight = title.width(withConstrainedHeight: 33.5, font: font) + 32
        }else{
            wight = title.width(withConstrainedHeight: 33.5, font: font) + 32
        }
        return wight
    }
}
