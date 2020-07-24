//
//  StockCollectionDelegate.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol StockCollectionDelegate: TabMainDelegate{
    func aboutStock(stockCellViewModel: StockCellViewModel?) //добавим indexPath
}
