//
//  OrgMenuTableViewCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class OrgMenuTableViewCellViewModel: OrgMenuTableViewCellViewModelType{
    private var data = [String]()
    private var selectedIndexPath = IndexPath(row: 0, section: 0)
 
    init(items: [String], selectedIndexPath: IndexPath){
        self.data = items
        self.selectedIndexPath = selectedIndexPath
    }
    
    func numberOfRow(in section: Int) -> Int {
        return self.data.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> BMenuCollectionCellViewModelType {
        var isSelected = false
        if selectedIndexPath.row == indexPath.row{
            isSelected = true
        }
        
        return BMenuCollectionCellViewModel(item: data[indexPath.row], isSelect: isSelected, indexPath: indexPath, basketCellType: .menuItems)
    }
    
    func didSelect(at indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    func getWightTextAt(indexPath: IndexPath) -> CGFloat {
           let font = UIFont(name:"Rubik-Medium", size:14.0)!
           var wight : CGFloat = 0.0
           
           let title = self.data[indexPath.row]
           let words = title.split(separator: " ")
           if words.count > 1 || title.contains("-"){
               wight = title.width(withConstrainedHeight: 33.5, font: font) + 16
           }else{
               wight = title.width(withConstrainedHeight: 33.5, font: font) + 40
           }
           return wight
       }
}
