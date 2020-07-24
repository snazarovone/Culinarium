//
//  BallsFeedbackTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 07.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BallsFeedbackTableViewCell: UITableViewCell {
    
    @IBOutlet weak var picture: UIImageViewDesignable!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var countBalls: UILabel!
    
    private weak var feedbackDelegate: BallsFeedbackDelegate?
    
    weak var dataFeedback: BallsFeedbackCellViewModelType?{
        willSet(data){
            feedbackDelegate = data?.feedbackDelegate
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
    
    
    @IBAction func feedback(_ sender: UIButton) {
        feedbackDelegate?.feedbackAction()
    }
}
