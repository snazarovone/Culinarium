//
//  OrderAcceptedViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 20.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol OrderAcceptedViewModelType {
    var numberOrder: String {get}
    var deliveryMethod: String {get}
    var address: String {get}
    var time: String {get}
    var sum: String {get}
}
