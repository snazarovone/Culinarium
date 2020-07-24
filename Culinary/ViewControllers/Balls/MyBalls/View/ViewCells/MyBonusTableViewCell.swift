//
//  MyBonusTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class MyBonusTableViewCell: UITableViewCell {
    
    private weak var bonusDelegate: MyBonusDelegate?
    
    weak var dataMyBonus: MyBonusCellViewModelType?{
        willSet(data){
            self.bonusDelegate = data?.myBonusDelegate
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
    
    @IBAction func howGetBonus(_ sender: Any) {
        bonusDelegate?.howGetBalls()
    }
    
    @IBAction func howSpendBonus(_ sender: Any) {
        bonusDelegate?.howSpendBalls()
    }
    
}
