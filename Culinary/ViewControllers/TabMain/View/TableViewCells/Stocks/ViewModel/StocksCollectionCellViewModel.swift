//
//  StocksCollectionCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class StocksCollectionCellViewModel: StocksCollectionCellViewModelType{
    var imageStock: String?{
        return stocks?.image
    }
    
    var cellSize: CGSize
    
    private let stocks: StocksActions?
    
    init(stocks: StocksActions?){
        self.stocks = stocks
        self.cellSize = CGSize(width: 280, height: 144)
    }
}
