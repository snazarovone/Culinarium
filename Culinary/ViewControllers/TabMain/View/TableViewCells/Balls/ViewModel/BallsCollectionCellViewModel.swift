//
//  BallsCollectionCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BallsCollectionCellViewModel: BallsCollectionCellViewModelType{
    var cellSize: CGSize
    
    init(){
        self.cellSize = CGSize(width: 200.0, height: 290.0)
    }
}
