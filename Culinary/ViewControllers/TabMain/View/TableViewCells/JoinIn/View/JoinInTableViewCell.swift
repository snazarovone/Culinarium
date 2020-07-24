//
//  JoinInTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class JoinInTableViewCell: UITableViewCell {

    @IBOutlet weak var countBalls: UILabel! //10 баллов is default
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func vk(_ sender: UIButton) {
    }
    
    @IBAction func fb(_ sender: UIButton) {
    }
    
    @IBAction func instagramm(_ sender: UIButton) {
    }
}
