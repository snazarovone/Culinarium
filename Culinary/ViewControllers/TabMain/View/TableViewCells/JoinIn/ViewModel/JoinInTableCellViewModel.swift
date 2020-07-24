//
//  JoinInTableCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class JoinInTableCellViewModel: TabMainTableCellType{
    var tabMainCellType: TabMainCellType
    var heightCell: CGFloat
    
    init(tabMainCellType: TabMainCellType){
        self.tabMainCellType = tabMainCellType
        self.heightCell = 219.0 //если есть данные в коллекции
    }
}
