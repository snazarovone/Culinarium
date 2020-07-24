//
//  CafePlacesViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 26.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol CafePlacesViewModelType {
    func numberOfRow() -> Int
    func cellForRow(at indexPath: IndexPath) -> CafePlaceCellViewModelType
    func didSelectRow(at indexPath: IndexPath) -> Int?
}
