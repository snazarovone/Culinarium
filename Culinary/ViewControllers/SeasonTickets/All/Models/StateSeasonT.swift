//
//  StateSeasonT.swift
//  Culinary
//
//  Created by Sergey Nazarov on 11.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

enum StateSeasonT: CaseIterable{
    case my
    case available //доступные
}

extension StateSeasonT{
    var tag: Int{
        switch self {
        case .my:
            return 0
        case .available:
            return 1
        }
    }
}

