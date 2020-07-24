//
//  FavoritesTableCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class FavoritesTableCellViewModel: TabMainTableCellType, FavoritesTableCellViewModelType{
    
    
    var tabMainCellType: TabMainCellType
    var heightCell: CGFloat
    weak var favoritesDelegate: FavoritesDelegate?
    var favoritesDish: BehaviorRelay<MenuSectionsModel?>
    private var allDishes = [DisheModel]()
    
    init(tabMainCellType: TabMainCellType, tabMainDelegate: TabMainDelegate?, favoritesDish: BehaviorRelay<MenuSectionsModel?>){
        self.tabMainCellType = tabMainCellType
        self.favoritesDelegate = tabMainDelegate as? FavoritesDelegate
        self.favoritesDish = favoritesDish

        if favoritesDish.value != nil && favoritesDish.value?.data != nil{
            for dishes in favoritesDish.value!.data ?? []{
                if (dishes.dishes?.count ?? 0) > 0{
                    self.heightCell = 296.0 //если есть данные в коллекции
                    return
                }
            }
        }
        self.heightCell = 0.0 //скрываем секцию
    }
    
    public func getAllDishes(){
        self.allDishes = []
        guard let favoritesDish = favoritesDish.value?.data else {
            return
        }
        
        for favoriteSection in favoritesDish{
            if let dishes = favoriteSection.dishes{
                for dish in dishes{
                    if dish.wishlist == .favorite{
                        self.allDishes.append(dish)
                    }
                }
            }
        }
    }
    
    //MARK:- CollectionView
    func numberOfItemsInSection(at section: Int) -> Int {
        //Получаем список всех блюд для отображения без секция
        getAllDishes()
        return allDishes.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> FavoritesCollectionCellViewModelType {
        return FavoritesCollectionCellViewModel(dish: allDishes[indexPath.row])
    }
    
    func didSelect(at indexPath: IndexPath) -> DisheModel? {
        return allDishes[indexPath.row]
    }
    
}
