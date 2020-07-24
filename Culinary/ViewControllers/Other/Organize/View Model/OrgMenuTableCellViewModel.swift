//
//  OrgMenuTableCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class OrgMenuTableCellViewModel: OrganizeTableCellModelType, OrgMenuTableCellViewModelType{
   
    var organizeTableCellType: OrganizeTableCellType{
        return .menu
    }
  
    var items: [String]
    var selectedItem: IndexPath
    
    init(items: [OrgMenuItem], selectedItem: IndexPath){
        var itemsTemp = [String]()
        for i in items{
            itemsTemp.append(i.title)
        }
        self.items = itemsTemp
        self.selectedItem = selectedItem
    }
}
