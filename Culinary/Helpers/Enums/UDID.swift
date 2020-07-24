//
//  UDID.swift
//  Culinary
//
//  Created by Sergey Nazarov on 03.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

//Все ключи используемые в UserDefaults

enum UDID{
    case dataLogin
}

extension UDID{
    var key: String{
        switch self {
        case .dataLogin:
            return "dataLogin"
        }
    }
}
