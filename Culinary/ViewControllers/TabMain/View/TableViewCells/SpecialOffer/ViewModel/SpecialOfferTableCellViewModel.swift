//
//  SpecialOfferTableCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class SpecialOfferTableCellViewModel: TabMainTableCellType, SpecialOfferTableCellViewModelType{
    var tabMainCellType: TabMainCellType
    var heightCell: CGFloat
    
    weak var specialOfferDelegate: SpecialOfferDelegate?
    
    init(tabMainCellType: TabMainCellType, specialOfferDelegate: SpecialOfferDelegate?){
        self.tabMainCellType = tabMainCellType
        self.heightCell = 396.0 //если есть данные в коллекции
        self.specialOfferDelegate = specialOfferDelegate
    }
    
    //MARK:- CollectionView
    func numberOfItemsInSection(at section: Int) -> Int {
        return 4
    }
    
    func cellForRow(at indexPath: IndexPath) -> SpecialOfferCollectionCellViewModelType {
        return SpecialOfferCollectionCellViewModel()
    }
    
}
