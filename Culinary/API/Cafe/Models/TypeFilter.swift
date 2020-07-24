//
//  TypeFilter.swift
//  Culinary
//
//  Created by Sergey Nazarov on 11.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

enum TypeFilter: CaseIterable{
    case typeInstitution //вид заведения
    case inRadius //В радиусе
    case deliveryAreas//Зоны доставки
}

extension TypeFilter{
    var id: Int{
        switch self {
        case .typeInstitution:
            return 1
        case .inRadius:
            return 3
        case .deliveryAreas:
            return 2
        }
    }
}
