//
//  BCountDishTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BCountDishTableViewCell: UITableViewCell {

    @IBOutlet weak var countDishTitle: UILabel!
    
    weak var dataCountDish: BCountDishViewModelType?{
        willSet(data){
            countDishTitle.text = data?.countDish
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
