//
//  BallsProfileTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 07.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BallsProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var picture: UIImageViewDesignable!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var countBalls: UILabel!
    
    private weak var profileDelegate: BallsProfileDelegate?
    
    weak var dataProfile: BallsProfileCellViewModelType?{
        willSet(data){
            self.profileDelegate = data?.profileDelegate
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
    
    @IBAction func fillForm(_ sender: UIButton) {
        self.profileDelegate?.fillOutForm()
    }
    
}
