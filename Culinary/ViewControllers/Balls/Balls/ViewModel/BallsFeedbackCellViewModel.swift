//
//  BallsFeedbackCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 07.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class BallsFeedbackCellViewModel: BallsFeedbackCellViewModelType, BallsEarnModelType{
  
    weak var ballsDelegate: BallsEarnDelegate?
    var ballsEarnCellType: BallsEarnCellType
    weak var feedbackDelegate: BallsFeedbackDelegate?
    
    init(ballsEarnModel: BallsEarnModel){
        self.ballsEarnCellType = ballsEarnModel.ballsEarnCellType
        self.feedbackDelegate = ballsEarnModel.ballsDelegate as? BallsFeedbackDelegate
        self.ballsDelegate = ballsEarnModel.ballsDelegate
    }
    
}
