//
//  BNotForgetDishCollectionViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BNotForgetDishCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageViewDesignable!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var titleDish: UILabel!
    @IBOutlet weak var countStep: UIStackView! //hide if count = 0
    @IBOutlet weak var addBasket: UIButtonDesignable! //hide if > 0
    @IBOutlet weak var countTF: UITextFieldDesignable!
    
    weak var dataCell: BNotForgetDishCollectionViewModelType?{
        willSet(data){
            self.img.image = data?.img
            self.price.text = data?.price
            self.currency.text = data?.currency
            self.titleDish.text = data?.titleDish
            self.countTF.text = data?.countDishStep
            self.addBasket.isHidden = data?.addBasketIsHide ?? false
            self.countStep.isHidden = data?.countStepViewIsHide ?? true
        }
    }
    
    @IBAction func minusAction(_ sender: UIButton) {
    }
    
    @IBAction func plusAction(_ sender: UIButton) {
    }
    
    
}
