//
//  MyBonusCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class MyBonusCellViewModel: MyBallsType, MyBonusCellViewModelType{
   
    var myBallsCellType: MyBallsCellType
    var heightCell: CGFloat
    weak var myBonusDelegate: MyBonusDelegate?
    
    init(myBallsType: MyBallsType, delegate: MyBallsDelegate?){
        self.myBallsCellType = myBallsType.myBallsCellType
        self.heightCell = myBallsType.heightCell
        self.myBonusDelegate = delegate as? MyBonusDelegate
    }
}
