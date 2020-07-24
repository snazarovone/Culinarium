//
//  BallsProfileCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 07.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class BallsProfileCellViewModel: BallsProfileCellViewModelType, BallsEarnModelType{
  
    var ballsEarnCellType: BallsEarnCellType
    weak var profileDelegate: BallsProfileDelegate?
    weak var ballsDelegate: BallsEarnDelegate?
    
    init(ballsEarnModel: BallsEarnModel){
        self.ballsEarnCellType = ballsEarnModel.ballsEarnCellType
        self.profileDelegate = ballsEarnModel.ballsDelegate as? BallsProfileDelegate
        self.ballsDelegate = ballsEarnModel.ballsDelegate
    }
}
