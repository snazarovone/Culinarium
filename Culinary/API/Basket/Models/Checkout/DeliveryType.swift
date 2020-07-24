//
//  DeliveryType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 17.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

enum DeliveryType {
    case pickup
    case courier
}

extension DeliveryType{
    var id: Int{
        switch self {
        case .courier:
            return 2
        case .pickup:
            return 1
        }
    }
}
