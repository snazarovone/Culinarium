//
//  MyBallsActionsTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class MyBallsActionsTableViewCell: UITableViewCell {
    
    weak var dataActions: MyBallsActionsCellViewModelType?{
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
