//
//  StocksCollectionCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol StocksCollectionCellViewModelType: class{
    var cellSize: CGSize {get}
    var imageStock: String? {get}
}
