//
//  AboutOrderDishCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 14.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol AboutOrderDishCellViewModelType: class {
    var image: String? {get}
    var titleDish: String {get}
    var weightDish: String {get}
    var countDish: String {get}
}
