//
//  StocksTableCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol StocksTableCellViewModelType: class {
    func numberOfItemsInSection(at section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> StocksCollectionCellViewModelType
    
    var stocksDelegate: StocksDelegate? {get}
    var stockCollectionDelegate: StockCollectionDelegate? {get}
    
}
