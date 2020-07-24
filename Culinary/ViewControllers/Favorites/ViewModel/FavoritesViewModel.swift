//
//  FavoritesViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FavoritesViewModel: FavoritesViewModelType{
 
    var favoritesDish: BehaviorRelay<MenuSectionsModel?>
    private var sectionsMenu = [MenuSection]()
    
    var selectedFilter: IndexPath = IndexPath(item: 0, section: 0)
    
    init(favoritesDish: BehaviorRelay<MenuSectionsModel?>){
        self.favoritesDish = favoritesDish
        updateSection()
    }
    
    func updateSection(){
        sectionsMenu.removeAll()
        guard let favoritesDish = favoritesDish.value else {
            return
        }
        var allDishes = [DisheModel]()
        
        for favSec in favoritesDish.data ?? []{
            sectionsMenu.append(favSec)
            for dish in favSec.dishes ?? []{
                allDishes.append(dish)
            }
        }
        if allDishes.count > 0{
            let model = MenuSection(title: "Все", dishes: allDishes)
            sectionsMenu.insert(model, at: 0)
        }
    }
    
    
    //MARK:- Collection Filters
    func numberOfRowInSection() -> Int {
        return sectionsMenu.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> FavoriteFilterCollectionViewCellType {
        var isSelected = false
        if selectedFilter.row == indexPath.row{
            isSelected = true
        }
        return FavoriteFilterCollectionViewCell(menuSection: self.sectionsMenu[indexPath.row], isSelected: isSelected)
    }
    
    func didSelectFilter(at indexPath: IndexPath) {
        self.selectedFilter = indexPath
    }
    
    func getWightTextAt(indexPath: IndexPath) -> CGFloat {
        let font = UIFont(name:"Rubik-Medium", size:14.0)!
        var wight : CGFloat = 0.0

        let title = self.sectionsMenu[indexPath.row].title ?? ""
        wight = title.width(withConstrainedHeight: 15.5, font: font) + 24
        return wight

    }
   
    //MARK:- Collection Eat
    func numberOfRowInSectionCollectionEat() -> Int {
        if selectedFilter.row < sectionsMenu.count{
            return sectionsMenu[selectedFilter.row].dishes?.count ?? 0
        }else{
            selectedFilter = IndexPath(item: 0, section: 0)
            if selectedFilter.row < sectionsMenu.count{
                return sectionsMenu[selectedFilter.row].dishes?.count ?? 0
            }else{
                return 0
            }
        }
        
    }
    
    func cellForRowCollectionEat(at indexPath: IndexPath) -> CatMenuCellViewModelType {
        return CatMenuCellViewModel(dish: sectionsMenu[selectedFilter.row].dishes![indexPath.row], selectPortion: 0)
    }
    
    func getDish(at indexPath: IndexPath) -> DisheModel? {
        if indexPath.section < self.sectionsMenu.count && indexPath.row < self.sectionsMenu[indexPath.section].dishes?.count ?? 0{
            return self.sectionsMenu[indexPath.section].dishes![indexPath.row]
        }else{
            return nil
        }
    }
}

