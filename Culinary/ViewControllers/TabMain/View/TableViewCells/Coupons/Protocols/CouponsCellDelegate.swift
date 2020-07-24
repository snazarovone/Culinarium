//
//  CouponsCellDelegate.swift
//  Culinary
//
//  Created by Sergey Nazarov on 09.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol CouponsCellDelegate{
    var cellSize: CGSize {get}
    var viewCollection: ViewCollection? {get} //card or grid
    var couponsModel: CouponsModel {get}
}
