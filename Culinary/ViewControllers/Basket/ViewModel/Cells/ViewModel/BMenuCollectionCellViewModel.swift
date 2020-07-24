//
//  BMenuCollectionCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 23.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BMenuCollectionCellViewModel: BMenuCollectionCellViewModelType{
    var item: String
    
    var background: UIColor{
        if isSelect{
            return UIColor(named: "RedA4262A") ?? .red
        }else{
            return .white
        }
    }
    
    var colorShadow: UIColor{
        if isSelect{
            return UIColor(named: "Red_550A0C") ?? .red
        }else{
            return UIColor(named: "Black282A2F") ?? .black
        }
    }
    
    var titleColor: UIColor{
        if isSelect{
            return .white
        }else{
            return UIColor(named: "Black282A2F") ?? .black
        }
    }
    
    var isSelect: Bool
    
    var indexPath: IndexPath
    
    var basketCellType: BasketCellType
    
    init(item: String, isSelect: Bool, indexPath: IndexPath, basketCellType: BasketCellType){
        self.item = item
        self.isSelect = isSelect
        self.indexPath = indexPath
        self.basketCellType = basketCellType
    }
}
