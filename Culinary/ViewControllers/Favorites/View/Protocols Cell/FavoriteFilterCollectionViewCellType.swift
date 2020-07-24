//
//  FavoriteFilterCollectionViewCellType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol FavoriteFilterCollectionViewCellType: class {
    var title: String {get}
    var isSelected: Bool {get}
}

