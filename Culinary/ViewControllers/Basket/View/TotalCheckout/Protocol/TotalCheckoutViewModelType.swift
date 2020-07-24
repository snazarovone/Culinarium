//
//  TotalCheckoutViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 19.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol TotalCheckoutViewModelType {
    var weightOrder: String {get}
    var countPortions: String {get}
    var sumOrder: String {get}
    var discont: String {get}
    var deliveryPrice: String {get}
    var toPay: String {get}
    var idBasket: Int? {get}
}
