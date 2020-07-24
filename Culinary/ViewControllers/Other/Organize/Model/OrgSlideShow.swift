//
//  OrgSlideShow.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class OrgSlideShow: OrganizeTableCellModelType, OrgSlideShowType{
    var organizeTableCellType: OrganizeTableCellType{
        return .slideShow
    }
    
    var items: [UIImage]
    var currentPage: Int = 0
    
    init(items: [UIImage]){
        self.items = items
    }
    
}
