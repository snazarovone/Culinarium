//
//  AddressCafeCellModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import UIKit

protocol AddressCafeCellModelType: class {
    var nameCafe: String? {get}
    var timeWork: String? {get}
    var addressCafe: String? {get}
    var metroName: String? {get}
    var colorCircle: UIColor? {get}
}
