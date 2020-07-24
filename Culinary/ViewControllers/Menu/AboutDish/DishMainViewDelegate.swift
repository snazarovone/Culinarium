//
//  DishMainViewDelegate.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol DishMainViewDelegate: class {
    func dishShowWaitOverlay()
    func dishRemoveWaitOverlay()
    func logOut()
}
