//
//  FavoriteFilterCollectionViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class FavoriteFilterCollectionViewCell: FavoriteFilterCollectionViewCellType{
 
    var isSelected: Bool
    
    var title: String
    
    init(menuSection: MenuSection, isSelected: Bool){
        self.isSelected = isSelected
        self.title = menuSection.title ?? ""
    }
}
