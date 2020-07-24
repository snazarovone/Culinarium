//
//  SearchMenuViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 07.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

class SearchMenuViewModel{
    private var dishes = [DisheModel]()
    
    init(dishes: [DisheModel]){
        self.dishes = dishes
    }
    
    func updateDishes(favorites: MenuSectionsModel){
        for dish in self.dishes{
            var isFound = false
            if let dID = dish.id{
                for fav in favorites.data ?? []{
                    for fDish in fav.dishes ?? []{
                        if let id = fDish.id, dID == id{
                            dish.wishlist = .favorite
                            isFound = true
                        }
                    }
                }
            }
            if isFound == false{
                dish.wishlist = .unFavorite
            }
        }
    }
}

extension SearchMenuViewModel: CatMenuBottomViewModelType{
    func getAuth() -> ErrorAuth? {
        return nil
    }
    
    func numberOfRow() -> Int {
        return dishes.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> CatMenuCellViewModelType {
        return CatMenuCellViewModel(dish: dishes[indexPath.row], selectPortion: 0)
    }
    
    func getDish(at indexPath: IndexPath) -> DisheModel? {
        return dishes[indexPath.row]
    }
    
}
