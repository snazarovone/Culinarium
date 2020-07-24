//
//  OtherRedTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 26.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class OtherRedTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleHeader: UILabel!
    @IBOutlet weak var descreption: UILabel!
    
    weak var dataRedCell: OtherRedCellViewModelType?{
        willSet(data){
            self.img.image = data?.img
            self.titleHeader.text = data?.header
            self.descreption.text = data?.description
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
