//
//  FilterTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 30.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var iaSelect: UIButtonDesignable!
    
    weak var dataFilter: FilterCellViewModelType?{
        willSet(data){
            name.text = data?.name
            iaSelect.setImage(data?.select, for: .normal)
            iaSelect.borderC = data?.borderColor ?? .black
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

    @IBAction func selectAction(_ sender: UIButton) {
    }
}
