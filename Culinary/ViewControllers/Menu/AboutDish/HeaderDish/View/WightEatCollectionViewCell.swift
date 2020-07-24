//
//  WightEatCollectionViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 22.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class WightEatCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var weightTitle: UILabel!
    @IBOutlet weak var bgView: UIViewDesignable!
    
    
    weak var dataWight: WightEatCellViewModelType?{
        willSet(data){
            self.weightTitle.text = data?.weight
            self.bgView.backgroundColor = data?.bgColor
            self.weightTitle.textColor = data?.textColor
        }
    }
}
