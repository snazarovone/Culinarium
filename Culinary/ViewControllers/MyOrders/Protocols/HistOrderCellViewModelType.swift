//
//  HistOrderCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 14.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol HistOrderCellViewModelType: class {
    var backgroundViewColor: UIColor {get}
    var numberOrder: String? {get}
    var position: String? {get}
    var createDate: String? {get}
    var deliveryDate: String? {get}
    var payment: String? {get}
    var price: String? {get}
    var id: Int? {get}
    
}
