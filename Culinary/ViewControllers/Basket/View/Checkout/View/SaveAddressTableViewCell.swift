//
//  SaveAddressTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 17.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class SaveAddressTableViewCell: UITableViewCell {
    @IBOutlet weak var titleAddress: UILabel!
    @IBOutlet weak var address: UILabel!
    
    weak var dataSaveAddress: SaveAddressCellViewModelType?{
        willSet(data){
            self.titleAddress.text = data?.titleAddress
            self.address.text = data?.address
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
