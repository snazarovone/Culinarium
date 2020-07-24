//
//  GalleryDishViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 18.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class GalleryDishViewModel: GalleryDishViewModelType{
    
    private var gallery = [String]()
    
    init(gallery: [String]){
        self.gallery = gallery
    }
    
    func numberOfRow() -> Int {
        return gallery.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> DishCellViewModelType {
        return DishCellViewModel(urlImage: gallery[indexPath.row])
    }
}
