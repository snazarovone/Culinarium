//
//  StocksTableCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class StocksTableCellViewModel: TabMainTableCellType, StocksTableCellViewModelType{
    var heightCell: CGFloat
  
    var tabMainCellType: TabMainCellType
    weak var stocksDelegate: StocksDelegate?
    weak var stockCollectionDelegate: StockCollectionDelegate?
    var stocks: BehaviorRelay<StocksModel?>
    
    init(tabMainCellType: TabMainCellType, tabMainDelegate: TabMainDelegate?, stocks: BehaviorRelay<StocksModel?>){
        self.tabMainCellType = tabMainCellType
        self.stocks = stocks
        if stocks.value?.actions?.count ?? 0 > 0{
            self.heightCell = 494.0 //если есть данные в коллекции
        }else{
            self.heightCell = 314.0 //если нет данных в коллекции
        }
        self.stocksDelegate = tabMainDelegate as? StocksDelegate
        self.stockCollectionDelegate = tabMainDelegate as? StockCollectionDelegate
    }
    
    //MARK:- CollectionView
    func numberOfItemsInSection(at section: Int) -> Int {
        return stocks.value?.actions?.count ?? 0
    }
    
    func cellForRow(at indexPath: IndexPath) -> StocksCollectionCellViewModelType {
        return StocksCollectionCellViewModel(stocks: stocks.value?.actions?[indexPath.row])
    }
}
