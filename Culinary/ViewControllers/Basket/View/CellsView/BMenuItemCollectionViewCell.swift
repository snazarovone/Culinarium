//
//  BMenuItemCollectionViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 23.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BMenuItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewCell: UIViewDesignable!
    @IBOutlet weak var titleCell: UILabel!
    
    weak var dataMenuCollection: BMenuCollectionCellViewModelType?{
        willSet(data){
            viewCell.backgroundColor = data?.background
            viewCell.shadowColor = data?.colorShadow
            titleCell.textColor = data?.titleColor
            titleCell.text = data?.item
        }
    }
}
