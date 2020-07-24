//
//  MyBallsHistoryModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class MyBallsHistoryModel: MyBallsType{
    var myBallsCellType: MyBallsCellType
    var heightCell: CGFloat
    
    init(myBallsCellType: MyBallsCellType){
        self.myBallsCellType = myBallsCellType
        self.heightCell = 382.0
    }
}
