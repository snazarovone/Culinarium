//
//  QuickFilters.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

//Оплата наличными 0 или 1
//Экспресс доставка 0 или 1
//Скидки 0 или 1

enum QuickFilters: CaseIterable {
    case cash_payment
    case not_cash_payment
    
    case express_delivery
    case not_express_delivery
    
    case discount
    case not_discount
}

extension QuickFilters{
    var value: Int{
        switch self {
        case .cash_payment:
            return 1
        case .not_cash_payment:
            return 0
        case .express_delivery:
            return 1
        case .not_express_delivery:
            return 0
        case .discount:
            return 1
        case .not_discount:
            return 0
        }
    }
}
