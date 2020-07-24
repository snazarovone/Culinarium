//
//  DishCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 18.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class DishCellViewModel: DishCellViewModelType{
    var urlImage: String?
    
    init(urlImage: String){
        self.urlImage = urlImage
    }
}
