//
//  BasketTotalTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BasketTotalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var wight: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var allPrice: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var currencyTotal: UILabel!
    
    weak var dataTotal: BasketTotalCellViewModelType?{
        willSet(data){
            wight.text = (data?.wight ?? " ")
            count.text = (data?.count ?? " ")
            price.text = (data?.price ?? " ")
            allPrice.text = (data?.allPrice ?? "")
            total.text = (data?.total ?? "")
            currencyTotal.text = (data?.currencyTotal ?? "")
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
