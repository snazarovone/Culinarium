//
//  DeliveryInfoCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 08.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol DeliveryInfoCellViewModelType: class{
    var img: UIImage {get}
    var titleInfo: String {get}
    var des1Line: String? {get}
    var des2Line: String? {get}
    var des1Line1Col: String? {get}
    var des1Line2Col: String? {get}
    var des2Line1Col: String? {get}
    var des2Line2Col: String? {get}
    var cellType: DeliveryCellType {get}
}
