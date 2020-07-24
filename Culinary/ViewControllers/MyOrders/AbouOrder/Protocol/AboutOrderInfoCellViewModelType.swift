//
//  AboutOrderInfoCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 23.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol AboutOrderInfoCellViewModelType: class {
    var nameUser: String? {get}
    var phoneNumber: String? {get} //Телефон:
    var deliveryType: String? {get}
    var timeOutDelivery: String? {get}
    var addressDelivery: String? {get}
    var paymet: String? {get}
    var commentUser: String? {get}
    var weight: String? {get} //гр.
    var countPortion: String? {get}
    var sum: String? {get}
    var discont: String? {get}
    var deliveryPrice: String? {get}
    var totalSum: String? {get}
    
}
