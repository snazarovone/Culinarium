//
//  BallsBuyerTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 07.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BallsBuyerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var picture: UIImageViewDesignable!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var countBalls: UILabel!
    
    private weak var buyerDelegate: BallsBuyerDelegate?
    
    weak var dataBuyer: BallsBuyerCellViewModelType?{
        willSet(data){
            self.buyerDelegate = data?.buyerDelegate
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

    
    @IBAction func goIn(_ sender: UIButton) {
        self.buyerDelegate?.participate()
    }
}
