//
//  WightEatCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 22.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol WightEatCellViewModelType: class {
    var weight: String {get}
    var isSelect: Bool {get}
    var bgColor: UIColor {get}
    var textColor: UIColor {get}
}
