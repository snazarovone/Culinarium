//
//  FavoriteEatCollectionViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import SDWebImage

class FavoriteEatCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pictureEat: UIImageViewDesignable!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var oldPrice: UILabel!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var weight: UILabel!
    
    weak var dataFavoritesEat: CatMenuCellViewModelType?{
        willSet(data){
            getImage(by: URL(string: data?.imageDish ?? ""))
         
            price.text = data?.newPrice
            currency.text = data?.currency
            oldPrice.attributedText = data?.oldPrice
            title.text = data?.titleDish
            weight.text = data?.weightDish
            heartBtn.setImage(data?.favorite, for: .normal)
        }
    }
    
    private func getImage(by url: URL?){
        pictureEat.sd_setImage(with: url, completed: nil)
    }
    
    @IBAction func heart(_ sender: UIButton) {
        
    }
    
}
