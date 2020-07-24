//
//  BallsBuyerCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 07.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class BallsBuyerCellViewModel: BallsBuyerCellViewModelType, BallsEarnModelType{
    var ballsEarnCellType: BallsEarnCellType
    weak var buyerDelegate: BallsBuyerDelegate?
    weak var ballsDelegate: BallsEarnDelegate?
    
    init(ballsEarnModel: BallsEarnModel){
        self.ballsEarnCellType = ballsEarnModel.ballsEarnCellType
        self.buyerDelegate = ballsEarnModel.ballsDelegate as? BallsBuyerDelegate
        self.ballsDelegate = ballsEarnModel.ballsDelegate
    }
}
