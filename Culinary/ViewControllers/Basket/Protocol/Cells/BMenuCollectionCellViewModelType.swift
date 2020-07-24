//
//  BMenuCollectionCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 23.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol BMenuCollectionCellViewModelType: class {
    var item: String {get}
    var background: UIColor {get}
    var colorShadow: UIColor {get}
    var titleColor: UIColor {get}
    var isSelect: Bool {get}
    var indexPath: IndexPath {get}
}
