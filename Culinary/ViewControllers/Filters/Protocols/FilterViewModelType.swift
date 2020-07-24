//
//  FilterViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 31.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol FilterViewModelType {
    func cellForRow(at indexPath: IndexPath) -> FilterCellViewModelType
    func numberOfRow(in section: Int) -> Int
    func numberSection() -> Int
    func sectionCollapsed(at section: Int) -> Bool
    func setCollapsed(at section: Int, collapsed: Bool)
    func headerName(at section: Int) -> String
    func toogleField(at indexPath: IndexPath)
    func applyNewFilters()
}
