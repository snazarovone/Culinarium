//
//  TabMainCellType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

//тип ячеек для добаления в таблицу
enum TabMainCellType: CaseIterable {
    case tabMainCellStocks
    case tabMainSeasonTickets
    case tabMainCoupons
    case tabMainBalls
    case tabMainSpecialOffer
    case tabMainFavorites
    case tabMainHit
    case tabMainJoinIn
}


extension TabMainCellType{
    var titleModel: String{
        switch self {
        case .tabMainCellStocks:
            return "Акции"
        case .tabMainSpecialOffer:
            return "Спецпредложения"
        default:
            return""
        }
    }
}
