//
//  MyBallsHistoryCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class MyBallsHistoryCellViewModel: MyBallsType, MyBallsHistoryCellViewModelType{
 
    var myBallsCellType: MyBallsCellType
    
    var heightCell: CGFloat
    
    init(myBallsType: MyBallsType){
        self.myBallsCellType = myBallsType.myBallsCellType
        self.heightCell = myBallsType.heightCell
    }
}
