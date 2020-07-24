//
//  FavoriteFilterAllCollectionViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class FavoriteFilterAllCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleFilter: UILabel!

    @IBOutlet weak var background: UIViewDesignable!
    
    weak var dataFilterAll: FavoriteFilterCollectionViewCellType?{
        willSet(data){
            self.titleFilter.text = data?.title
            
            //выделяем выбранный элемент
            if data?.isSelected == true {
                background.backgroundColor = UIColor(named: "LoginInRed")!
                background.shadowColor = UIColor(named: "Red_550A0C")!
                titleFilter.textColor = .white
            }else{
                background.backgroundColor = .white
                background.shadowColor = UIColor(named: "Black282A2F")!
                titleFilter.textColor = UIColor(named: "Black282A2F")!
            }
        }
    }
}
