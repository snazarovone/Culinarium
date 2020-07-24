//
//  FavoritesCollectionViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import SDWebImage

class FavoritesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pictureEat: UIImageViewDesignable!
    @IBOutlet weak var heart: UIButton! //is default red
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var titleEat: UILabel!
    
    weak var dataFavorites: FavoritesCollectionCellViewModelType?{
        willSet(data){
            getImage(by: URL(string: data?.imageDish ?? ""))
            price.text = data?.newPrice
            currency.text = data?.currency
            titleEat.text = data?.titleDish
        }
    }
    
    private func getImage(by url: URL?){
        pictureEat.sd_setImage(with: url, completed: nil)
    }
    
    
    @IBAction func heartAction(_ sender: UIButton) {
    }
    
}
