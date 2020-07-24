//
//  OrgMenuModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class OrgMenuModel: OrganizeTableCellModelType, OrgMenuModelType{
    var organizeTableCellType: OrganizeTableCellType{
        return .menu
    }
    
    var items: [OrgMenuItem]
    var selectedItem: IndexPath = IndexPath(row: 0, section: 0)
    
    init(items: [OrgMenuItem]){
        self.items = items
    }
}
