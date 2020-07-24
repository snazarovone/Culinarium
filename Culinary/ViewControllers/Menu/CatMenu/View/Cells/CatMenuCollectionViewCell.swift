//
//  CatMenuCollectionViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 15.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import SDWebImage

class CatMenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgDish: UIImageViewDesignable!
    @IBOutlet weak var badgesNew: UIImageView!
    
    @IBOutlet weak var addBasketView: UIViewDesignable! //default isHide
    @IBOutlet weak var countInBasket: UILabel!
    @IBOutlet weak var removeBasket: UIButton!
    
    @IBOutlet weak var favorite_Btn: UIButton!
    
    @IBOutlet weak var newPrice: UILabel!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var oldPrice: UILabel!
    
    @IBOutlet weak var titleDish: UILabel!
    @IBOutlet weak var weightDish: UILabel!
    
    weak var dataCatMenu: CatMenuCellViewModelType? {
        willSet(data){
            getImage(by: URL(string: data?.imageDish ?? ""))
            badgesNew.isHidden = data?.badgesNew ?? true
            addBasketView.isHidden = data?.isHideInBasket ?? true
            countInBasket.text = data?.countInBasket
            newPrice.text = data?.newPrice
            currency.text = data?.currency
            oldPrice.attributedText = data?.oldPrice
            titleDish.text = data?.titleDish
            weightDish.text = data?.weightDish
            favorite_Btn.setImage(data?.favorite, for: .normal)
        }
    }
    
    private func getImage(by url: URL?){
        imgDish.sd_setImage(with: url, completed: nil)
    }
    
    @IBAction func favorite(_ sender: UIButton) {
    }
}
