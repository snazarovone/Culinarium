//
//  BNotForgetDishCollectionViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol BNotForgetDishCollectionViewModelType: class {
    var img: UIImage? {get}
    var price: String? {get}
    var currency: String? {get}
    var titleDish: String? {get}
    var countDishStep: String {get}
    
    var countStepViewIsHide: Bool {get}
    var addBasketIsHide: Bool {get}
}
