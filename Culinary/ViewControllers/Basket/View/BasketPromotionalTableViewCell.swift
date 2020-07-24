//
//  BasketPromotionalTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BasketPromotionalTableViewCell: UITableViewCell {
    @IBOutlet weak var promoTF: UITextFieldDesignable!
    @IBOutlet weak var doneBtn: UIButtonDesignable! //alpha = 0.6 && isEnable = flase  -default
    
    
    weak var dataPromotinal: BasketPromotionalCellViewModelType?{
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
