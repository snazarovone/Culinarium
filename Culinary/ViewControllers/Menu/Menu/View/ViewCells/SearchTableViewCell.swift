//
//  SearchTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 17.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    weak var dataSearch: SearchViewModelType?{
        willSet(data){
            self.name.text = data?.name
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
