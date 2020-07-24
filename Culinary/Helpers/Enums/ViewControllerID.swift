//
//  ViewControllerID.swift
//  Culinary
//
//  Created by Sergey Nazarov on 15.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

enum ViewControllerID {
    
    //MARK:- CatMenu
    case headerCatMenu
    case bottomCatMenu
    case catMenuXLPagerTabStrip
    case dishDescription
    case dishConsist
    case dishFeedback
}
extension ViewControllerID{
    var identifier: String{
        switch self {
        case .headerCatMenu:
            return "headerCatMenu"
        case .bottomCatMenu:
            return "CatMenuBottomViewController"
        case .catMenuXLPagerTabStrip:
            return "CatMenuXLPagerTabStrip"
        case .dishDescription:
            return "DishDescriptionViewController"
        case .dishConsist:
            return "DishConsistViewController"
        case .dishFeedback:
            return "DishFeedbackViewController"
        }
    }
}
