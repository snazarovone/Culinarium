//
//  BGiftTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BGiftTableViewCell: UITableViewCell {

    @IBOutlet weak var pictureEat: UIImageViewDesignable!
    @IBOutlet weak var titleDish: UILabel!
    @IBOutlet weak var wightDish: UILabel!
    
    weak var dataGift: BGiftCellViewModelType?{
        willSet(data){
            
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
