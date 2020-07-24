//
//  ErrorAuth.swift
//  Culinary
//
//  Created by Sergey Nazarov on 01.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

enum ErrorAuth {
    case Unauthorized
}

extension ErrorAuth{
    var value: String{
        switch self {
        case .Unauthorized:
            return "Unauthorized"
        }
    }
}
