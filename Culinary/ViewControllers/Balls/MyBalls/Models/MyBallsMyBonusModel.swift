//
//  MyBallsMyBonusModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class MyBallsMyBonusModel: MyBallsType{
    var myBallsCellType: MyBallsCellType
    var heightCell: CGFloat
    
    init(myBallsCellType: MyBallsCellType){
        self.myBallsCellType = myBallsCellType
        self.heightCell = 544.0
    }
}
