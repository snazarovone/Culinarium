//
//  BasketExtraDelegate.swift
//  Culinary
//
//  Created by Sergey Nazarov on 14.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol BasketExtraDelegate: class {
    func changeExtraQuantity(at idExtra: Int, count: Int)
}
