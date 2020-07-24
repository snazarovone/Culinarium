//
//  PaymentType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 17.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

enum PaymentType {
    case cash
    case online
}

extension PaymentType{
    var id: Int{
        switch self {
        case .cash:
            return 1
        case .online:
            return 2
        }
    }
}
