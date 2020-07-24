//
//  AboutOrderDishTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 14.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit
import SDWebImage

class AboutOrderDishTableViewCell: UITableViewCell {

    @IBOutlet weak var imgDish: UIImageViewDesignable!
    
    @IBOutlet weak var nameDish: UILabel!
    
    @IBOutlet weak var weightDish: UILabel!
    
    @IBOutlet weak var countDish: UILabel!
    
    weak var dataAboutDish: AboutOrderDishCellViewModelType?{
        willSet(data){
            getImage(by: URL(string: data?.image ?? ""))
            nameDish.text = data?.titleDish
            weightDish.text = data?.weightDish
            countDish.text = data?.countDish
        }
    }
    
    private func getImage(by url: URL?){
        //Placeholder!!
        imgDish.sd_setImage(with: url, completed: nil)
    }

}
