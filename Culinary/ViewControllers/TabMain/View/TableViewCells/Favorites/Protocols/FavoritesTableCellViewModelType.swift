//
//  FavoritesTableCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol FavoritesTableCellViewModelType: class {
    func numberOfItemsInSection(at section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> FavoritesCollectionCellViewModelType
    func didSelect(at indexPath: IndexPath) -> DisheModel?
    
    var favoritesDelegate: FavoritesDelegate? {get}
    var favoritesDish: BehaviorRelay<MenuSectionsModel?> {get}
}
