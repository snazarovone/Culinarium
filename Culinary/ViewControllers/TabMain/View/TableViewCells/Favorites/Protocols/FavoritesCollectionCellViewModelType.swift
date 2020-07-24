//
//  FavoritesCollectionCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol FavoritesCollectionCellViewModelType: class {
    var cellSize: CGSize {get}
    
    var imageDish: String? {get}
    var newPrice: String? {get}
    var currency: String? {get}
    var oldPrice: NSAttributedString? {get}
    var titleDish: String? {get}
}
