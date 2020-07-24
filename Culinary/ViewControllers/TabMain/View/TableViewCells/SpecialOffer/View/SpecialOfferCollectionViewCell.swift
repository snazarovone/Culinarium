//
//  SpecialOfferCollectionViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class SpecialOfferCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var shadowCell: UIViewDesignable! //background red is default
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var titleSpecOffer: UILabel!
    @IBOutlet weak var newPrice: UILabel!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var oldPrice: UILabel! //зачеркнуть
  
    weak var dataSpecialOffer: SpecialOfferCollectionCellViewModelType?{
        willSet(data){
            
        }
    }
}
