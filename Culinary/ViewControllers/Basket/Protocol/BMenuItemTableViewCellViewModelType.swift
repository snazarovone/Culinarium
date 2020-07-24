//
//  BMenuItemTableViewCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 23.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol BMenuItemTableViewCellViewModelType{
    func numberOfRow() -> Int
    func cellForRow(at indexPath: IndexPath) -> BMenuCollectionCellViewModelType
    func didSelect(at indexPath: IndexPath)
    func getWightTextAt(indexPath: IndexPath) -> CGFloat
}
