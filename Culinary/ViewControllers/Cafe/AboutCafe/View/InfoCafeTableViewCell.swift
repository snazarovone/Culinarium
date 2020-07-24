//
//  InfoCafeTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class InfoCafeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameInfo: UILabel!
    @IBOutlet weak var valueInfo: UILabel!
    
    weak var dataInfoCafe: InfoCafeCellViewModelType?{
        willSet(data){
            nameInfo.text = data?.nameInfo
            valueInfo.text = data?.valueInfo
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
