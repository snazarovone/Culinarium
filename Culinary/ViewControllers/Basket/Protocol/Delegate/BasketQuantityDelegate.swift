//
//  BasketQuantityDelegate.swift
//  Culinary
//
//  Created by Sergey Nazarov on 14.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol BasketQuantityDelegate: class {
    func addQuantity(at idDish: Int, count: Int)
    func removeQuantity(at idDish: Int, count: Int)
}
