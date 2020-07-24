//
//  BGiftCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BGiftCellViewModel: BasketModelType, BGiftCellViewModelType{
    var wightDish: String?
    
    var titleDish: String?
    
    var pictureEat: UIImage?
    
    var basketCellType: BasketCellType
    
    init(basketCellType: BasketCellType){
        self.basketCellType = basketCellType
    }
    
}
