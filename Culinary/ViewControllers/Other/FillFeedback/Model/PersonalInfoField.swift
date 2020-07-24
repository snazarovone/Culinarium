//
//  PersonalInfoField.swift
//  Culinary
//
//  Created by Sergey Nazarov on 26.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

enum PersonalInfoField: CaseIterable{
    case name
    case surname
    case phone
    case advantages
    case disadvantages
}

extension PersonalInfoField{
    var tag: Int{
        switch self {
        case .name:
            return 1
        case .surname:
            return 0
        case .phone:
            return 2
        case .advantages:
            return 3
        case .disadvantages:
            return 4
        }
    }
}
