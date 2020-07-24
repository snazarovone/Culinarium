//
//  BasketDishCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol BasketDishCellViewModelType: class {
    var idItemInBasket: Int? {get}
    var urlImageDish: String? {get}
    var nameDish: String? {get}
    var portionW: String? {get}
    var quantity: String {get}
    var price: String? {get}
    var currency: String? {get}
    var descPriceAndQuantity: String? {get}
}
