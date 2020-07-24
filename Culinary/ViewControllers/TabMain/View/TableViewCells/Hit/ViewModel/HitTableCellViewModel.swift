//
//  HitTableCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class HitTableCellViewModel: TabMainTableCellType{
    var tabMainCellType: TabMainCellType
    var heightCell: CGFloat
    
    init(tabMainCellType: TabMainCellType){
        self.tabMainCellType = tabMainCellType
        self.heightCell = 520.0 //если есть данные в коллекции
    }
}
