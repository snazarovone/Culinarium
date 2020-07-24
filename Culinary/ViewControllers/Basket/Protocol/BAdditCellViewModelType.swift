//
//  BAdditCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol BAdditCellViewModelType: class{
    var countCutlery: String {get}
    var countGlass: String {get}
    var idExtraGlass: Int? {get}
    var idExtraCutlery: Int? {get}
}
