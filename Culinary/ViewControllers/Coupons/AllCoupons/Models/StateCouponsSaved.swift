//
//  StateCouponsSaved.swift
//  Culinary
//
//  Created by Sergey Nazarov on 09.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

enum StateCouponsSaved: CaseIterable{
    case online
    case offline
}

extension StateCouponsSaved{
    var tag: Int{
        switch self {
        case .online:
            return 0
        case .offline:
            return 1
        }
    }
}

