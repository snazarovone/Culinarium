//
//  BallsShareCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 07.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class BallsShareCellViewModel: BallsShareCellViewModelType, BallsEarnModelType{
   
    weak var ballsDelegate: BallsEarnDelegate?
    var ballsEarnCellType: BallsEarnCellType
    weak var shareDelegate: BallsShareDelegate?
    
    init(ballsEarnModel: BallsEarnModel){
        self.ballsEarnCellType = ballsEarnModel.ballsEarnCellType
        self.shareDelegate = ballsEarnModel.ballsDelegate as? BallsShareDelegate
        self.ballsDelegate = ballsEarnModel.ballsDelegate
    }
}
