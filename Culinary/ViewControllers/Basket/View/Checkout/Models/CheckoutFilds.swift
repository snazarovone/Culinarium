//
//  CheckoutFilds.swift
//  Culinary
//
//  Created by Sergey Nazarov on 17.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

enum CheckoutFilds: CaseIterable {
    case name
    case phone
    case time
    case selectAddress
    case street
    case house
    case porch
    case flat
    case floor
    case door_code
    case titleAddress
    case exchange
}

extension CheckoutFilds{
    var tag: Int{
        switch self{
        case .name:
            return 0
        case .phone:
            return 1
        case .time:
            return 2
        case .selectAddress:
            return 3
        case .street:
            return 4
        case .house:
            return 5
        case .porch:
            return 6
        case .flat:
            return 7
        case .floor:
            return 8
        case .door_code:
            return 9
        case .titleAddress:
            return 10
        case .exchange:
            return 11
        }
    }
}
