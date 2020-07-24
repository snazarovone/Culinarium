//
//  CurrentOrderCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 21.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol CurrentOrderCellViewModelType: class {
    var numberOrder: String? {get}
    var position: String? {get}
    var createDate: String? {get}
    var deliveryDate: String? {get}
    var payment: String? {get}
    var price: String? {get}
    var id: Int? {get}
    
    var totalTime: Int64 {get}
}
