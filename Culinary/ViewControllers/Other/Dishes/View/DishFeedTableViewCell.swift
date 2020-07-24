//
//  DishFeedTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import SDWebImage

class DishFeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageDish: UIImageViewDesignable!
    @IBOutlet weak var nameDish: UILabel!
    @IBOutlet weak var portionDish: UILabel!
    @IBOutlet weak var menuDish: UILabel!
    
    
    weak var dataDish: DishFeedCellViewModelType?{
        willSet(data){
            getImage(by: URL(string: data?.imgDish ?? ""))
            nameDish.text = data?.nameDish
            portionDish.text = data?.protionDish
            menuDish.text = data?.typeDish
        }
    }
    
    private func getImage(by url: URL?){
        //Placeholder!!
        imageDish.sd_setImage(with: url, completed: nil)
    }
}
