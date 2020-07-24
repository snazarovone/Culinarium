//
//  OrgDescriptionModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 28.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class OrgDescriptionModel: OrganizeTableCellModelType{
    
    var organizeTableCellType: OrganizeTableCellType{
        return .descriptionOrg
    }
    
    var text: String
    
    init(text: String){
        self.text = text
    }
}
