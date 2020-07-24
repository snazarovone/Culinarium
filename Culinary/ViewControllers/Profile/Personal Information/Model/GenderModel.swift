//
//  GenderModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 12.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

enum GenderModel: CaseIterable {
    case man
    case women
}

extension GenderModel{
    var tag: Int{
        switch self {
        case .man:
            return 1
        case .women:
            return 0
        }
    }
}
