//
//  BNotForgetCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol BNotForgetCellViewModelType: class {
    var titleNotForget: String {get}
    var countFree: String {get}
    var dish: [BDishNotForgotModel] {get}
    var hightCountFreeV: CGFloat {get}
}
