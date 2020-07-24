//
//  OrgInfoCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 28.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class OrgInfoCellViewModel: OrganizeTableCellModelType, OrgInfoCellViewModelType{
   
    var img: UIImage?{
        return item.img
    }
    
    var titleInfo: String?{
        return item.titleMain
    }
    
    var descriptionInfo: String?{
        return item.titleDescription
    }
    
    var linkText: String?{
        return item.linkMap
    }
    
    var hideLinkBtn: Bool?{
        if item.linkMap == nil || item.linkMap!.isEmpty{
            return true
        }else{
            return false
        }
    }
    
    var hideDescriptionInfo: Bool?{
        if item.titleDescription == nil || item.titleDescription!.isEmpty{
            return true
        }else{
            return false
        }
    }
    
    var organizeTableCellType: OrganizeTableCellType{
        return .info
    }
    
    private let item: OrgInfoModel
    
    init(item: OrgInfoModel){
        self.item = item
    }
    
}
