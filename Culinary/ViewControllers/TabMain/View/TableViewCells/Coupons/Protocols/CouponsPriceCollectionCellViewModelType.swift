//
//  CouponsPriceCollectionCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 09.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol CouponsPriceCollectionCellViewModelType: class {
    var viewCollection: ViewCollection? {get} //card or grid
    var timeView: Bool {get}
    var couponsCollectionDelegate: CouponsCollectionDelegate? {get}
}
