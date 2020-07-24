//
//  SnsModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 31.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

//Если вход осуществляется через соц.сети, значение параметра = 1, иначе - 0
enum SnsModel {
    case authSns
    case notSns
}

extension SnsModel{
    var value: Int{
        switch self {
        case .authSns:
            return 1
        case .notSns:
            return 0
        }
    }
}
