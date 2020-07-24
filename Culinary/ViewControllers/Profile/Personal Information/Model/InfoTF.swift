//
//  InfoTF.swift
//  Culinary
//
//  Created by Sergey Nazarov on 12.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

enum InfoTF: CaseIterable {
    case surname
    case name
    case secondName
    case email
    case phone
    case birthday
}

extension InfoTF{
    var tag: Int{
        switch self {
        case .surname:
            return 0
        case .name:
            return 1
        case .secondName:
            return 2
        case .email:
            return 3
        case .phone:
            return 4
        case .birthday:
            return 5
        }
    }
}
