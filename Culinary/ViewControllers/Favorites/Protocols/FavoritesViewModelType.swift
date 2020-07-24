//
//  FavoritesViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol FavoritesViewModelType{
    func numberOfRowInSection() -> Int
    func cellForRow(at indexPath: IndexPath) -> FavoriteFilterCollectionViewCellType
    func getWightTextAt(indexPath: IndexPath) -> CGFloat
    func didSelectFilter(at indexPath: IndexPath)
    
    //MARK:- Collection Eat
    func numberOfRowInSectionCollectionEat() -> Int
    func cellForRowCollectionEat(at indexPath: IndexPath) -> CatMenuCellViewModelType
    func getDish(at indexPath: IndexPath) -> DisheModel?
    
    var selectedFilter: IndexPath {get}
}
