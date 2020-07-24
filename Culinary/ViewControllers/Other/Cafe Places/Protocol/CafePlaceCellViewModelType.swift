//
//  c.swift
//  Culinary
//
//  Created by Sergey Nazarov on 26.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import UIKit

protocol CafePlaceCellViewModelType: class {
    var street: String? {get}
    var nameCafe: String? {get}
    var nameMetroStatetion: String? {get}
    var circleColor: UIColor {get}
}
