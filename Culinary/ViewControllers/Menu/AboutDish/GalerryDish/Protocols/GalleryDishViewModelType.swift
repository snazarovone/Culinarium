//
//  GalleryDishViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 18.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol GalleryDishViewModelType {
    
    func numberOfRow() -> Int
    func cellForRow(at indexPath: IndexPath) -> DishCellViewModelType
}
