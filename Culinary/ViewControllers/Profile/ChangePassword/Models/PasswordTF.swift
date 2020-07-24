//
//  PasswordTF.swift
//  Culinary
//
//  Created by Sergey Nazarov on 12.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

enum PasswordTF: CaseIterable{
    case current
    case new
    case confirm
}

extension PasswordTF{
    var tag: Int{
        switch self {
        case .current:
            return 0
        case .new:
            return 1
        case .confirm:
            return 2
        }
    }
}
