//
//  StocksAllType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 08.04.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

enum StocksAllType {
    case stocks
    case specialOffers
}

extension StocksAllType{
    var title: String{
        switch self {
        case .stocks:
            return "Акции"
        case .specialOffers:
            return "Спецпредложения"
        }
    }
}
