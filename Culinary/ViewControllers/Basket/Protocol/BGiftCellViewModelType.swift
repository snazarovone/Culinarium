//
//  BGiftCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol BGiftCellViewModelType: class {
    var wightDish: String? {get}
    var titleDish: String? {get}
    var pictureEat: UIImage? {get}
}
