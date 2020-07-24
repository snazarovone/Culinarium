//
//  OrgSlideShowTableCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class OrgSlideShowTableCellViewModel: OrganizeTableCellModelType, OrgSlideShowTableCellViewModelType{
  
    var items: [UIImage]
    
    var countItems: Int{
        return items.count
    }
    
    var organizeTableCellType: OrganizeTableCellType{
        return .slideShow
    }
    
    init(items: [UIImage]) {
        self.items = items
    }
}
