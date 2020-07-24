//
//  BMenuTableCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 23.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol BMenuTableCellViewModelType: class {
    
    var itemsMenu: [String]{get}
    var currentIndex: IndexPath? {get}
}
