//
//  FavoritesFilterModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class FavoritesFilterModel: FavoritesFilterModelType{
    
    var menuSection: MenuSection?
    
    init(menuSection: MenuSection?){
        self.menuSection = menuSection
    }
}

