//
//  BallsEarnModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 07.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol BallsEarnModelType{
    var ballsEarnCellType: BallsEarnCellType {get}
    var ballsDelegate: BallsEarnDelegate? {get}
}
