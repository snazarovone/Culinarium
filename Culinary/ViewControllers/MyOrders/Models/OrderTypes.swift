//
//  OrderTypes.swift
//  Culinary
//
//  Created by Sergey Nazarov on 14.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

enum OrderTypes: CaseIterable {
    case current
    case history
}

extension OrderTypes{
    var tag: Int{
        switch self {
        case .current:
            return 1
        case .history:
            return 2
        }
    }
}
