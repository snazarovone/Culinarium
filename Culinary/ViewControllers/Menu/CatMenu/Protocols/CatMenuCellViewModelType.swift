//
//  CatMenuCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol CatMenuCellViewModelType: class {
    var imageDish: String? {get}
    var badgesNew: Bool? {get}
    var countInBasket: String? {get}
    var isHideInBasket: Bool? {get}
    var favorite: UIImage? {get}
    var newPrice: String? {get}
    var currency: String? {get}
    var oldPrice: NSAttributedString? {get}
    var titleDish: String? {get}
    var weightDish: String? {get}
}
