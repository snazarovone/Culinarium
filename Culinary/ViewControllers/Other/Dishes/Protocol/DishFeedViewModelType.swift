//
//  DishFeedViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 28.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol DishFeedViewModelType {
    func numberForRaw() -> Int
    func cellForRow(at indexPath: IndexPath) -> DishFeedCellViewModelType
    func didSelectRow(at indexPath: IndexPath) -> Int?
}
