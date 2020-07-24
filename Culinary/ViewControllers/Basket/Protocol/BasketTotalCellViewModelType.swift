//
//  BasketTotalCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol BasketTotalCellViewModelType: class {

    var wight: String? {get}
    var count: String? {get}
    var price: String? {get}
    var allPrice: String? {get}
    var total: String? {get}
    var currencyTotal: String? {get}
}
