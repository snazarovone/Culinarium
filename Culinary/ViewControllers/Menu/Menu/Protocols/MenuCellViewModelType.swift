//
//  MenuCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 16.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol MenuCellViewModelType: class{
    var typeCell: PositionMenu {get}
    var title: String? {get}
    var description: String? {get}
    var image: URL? {get}
    var color: UIColor? {get}
}
