//
//  BNotForgetTableViewCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol BNotForgetTableViewCellViewModelType{
    func numberOfRow() -> Int
    func cellForRow(at indexPath: IndexPath) -> BNotForgetDishCollectionViewModelType
}
