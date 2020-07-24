//
//  OrgDescriptionViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 28.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class OrgDescriptionViewModel: OrganizeTableCellModelType, OrgDescriptionViewModelType {
 
    var textDesc: String
    

    var organizeTableCellType: OrganizeTableCellType{
        return .descriptionOrg
    }
    
    
    init(text: String){
        self.textDesc = text
    }
}
