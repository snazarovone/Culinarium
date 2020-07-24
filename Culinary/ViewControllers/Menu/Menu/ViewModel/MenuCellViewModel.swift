//
//  MenuCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 16.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import SDWebImage

class MenuCellViewModel: MenuCellViewModelType{
    var title: String?
    
    var description: String?
    
    var image: URL?
    
    var typeCell: PositionMenu
    
    var color: UIColor?
    
    init(menuSection: MenuSection){
        self.typeCell = menuSection.position
        self.title = menuSection.title
        self.description = menuSection.description
        self.image = URL(string: menuSection.image ?? "")
        self.color = menuSection.color
    }
}
