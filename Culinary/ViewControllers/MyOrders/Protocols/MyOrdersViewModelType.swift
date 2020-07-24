//
//  MyOrdersViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 14.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol MyOrdersViewModelType {
    func numberOfRow() -> Int
    func cellForRow(at indexPath: IndexPath) -> CurrentOrderCellViewModelType
    func cellForRowHist(at indexPath: IndexPath) -> HistOrderCellViewModelType
    func getAuth() -> ErrorAuth?
}
