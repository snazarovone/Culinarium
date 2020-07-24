//
//  StocksViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class StocksViewModel{
    
    public let stocksAllType: StocksAllType
    public var stocks: BehaviorRelay<StocksModel?> = BehaviorRelay(value: nil)
    
    init(stocksAllType: StocksAllType, stocks: BehaviorRelay<StocksModel?>){
        self.stocksAllType = stocksAllType
        self.stocks = stocks
    }
    
    init(stocksAllType: StocksAllType){
        self.stocksAllType = stocksAllType
    }
}

extension StocksViewModel: StocksViewModelType{
    func numberOfRow(in section: Int) -> Int {
        switch stocksAllType{
        case .stocks:
            return stocks.value?.actions?.count ?? 0
        case .specialOffers:
            return 5
        }
    }
    
    func cellForRow(at indexPath: IndexPath) -> StockCellViewModelType{
        switch stocksAllType{
        case .stocks:
            return StockCellViewModel( stocksAllType: stocksAllType, stock: stocks.value?.actions?[indexPath.row])
        case .specialOffers:
            return StockCellViewModel( stocksAllType: stocksAllType, stock: nil)
        }
    }
}
