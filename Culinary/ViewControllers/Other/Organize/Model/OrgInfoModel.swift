//
//  OrgInfoModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 28.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class OrgInfoModel: OrganizeTableCellModelType{
    var organizeTableCellType: OrganizeTableCellType{
        return .info
    }
    
    var img: UIImage?
    var titleMain: String?
    var titleDescription: String?
    var linkMap: String?
    
    init(img: UIImage?, titleMain: String?, titleDescription: String?, linkMap: String?){
        self.img = img
        self.titleMain = titleMain
        self.titleDescription = titleDescription
        self.linkMap = linkMap
    }
}
