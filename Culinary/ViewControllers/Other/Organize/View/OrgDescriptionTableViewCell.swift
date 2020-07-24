//
//  OrgDescriptionTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 28.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class OrgDescriptionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textDescription: UILabel!
    
    weak var dataDescription: OrgDescriptionViewModelType?{
        willSet(data){
            self.textDescription.text = data?.textDesc
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
