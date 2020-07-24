//
//  MyBallsActionsCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class MyBallsActionsCellViewModel: MyBallsType, MyBallsActionsCellViewModelType{
    
    var myBallsCellType: MyBallsCellType
    
    var heightCell: CGFloat
    
    init(myBallsType: MyBallsType){
        self.myBallsCellType = myBallsType.myBallsCellType
        self.heightCell = myBallsType.heightCell
    }
}
