//
//  FilterCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 31.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation
import UIKit

protocol FilterCellViewModelType: class{
    var name: String? {get}
    var select: UIImage? {get}
    var borderColor: UIColor? {get}
}
