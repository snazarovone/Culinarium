//
//  BallsEarnModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 07.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class BallsEarnModel: BallsEarnModelType{
   
    var ballsEarnCellType: BallsEarnCellType
    weak var ballsDelegate: BallsEarnDelegate?
    
    init(ballsEarnCellType: BallsEarnCellType, ballsDelegate: BallsEarnDelegate?){
        self.ballsEarnCellType = ballsEarnCellType
        self.ballsDelegate = ballsDelegate
    }
}
