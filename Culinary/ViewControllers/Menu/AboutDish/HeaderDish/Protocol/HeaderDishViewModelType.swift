//
//  HeaderDishViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 22.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol HeaderDishViewModelType {
    func numberOfRow(in section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> WightEatCellViewModelType
    func didSelectRow(at indexPath: IndexPath)
    func getWightTextAt(indexPath: IndexPath) -> CGFloat
    func getPortion() -> PortionsDish
}
