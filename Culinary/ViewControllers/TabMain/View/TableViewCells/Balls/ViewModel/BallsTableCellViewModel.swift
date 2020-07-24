//
//  BallsTableCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BallsTableCellViewModel: TabMainTableCellType, BallsTableCellViewModelType, MyBallsType{

    var myBallsCellType: MyBallsCellType
    var heightCell: CGFloat
 
    var tabMainCellType: TabMainCellType
    weak var ballsDelegate: BallsDelegate?
    
    init(tabMainCellType: TabMainCellType, ballsDelegate: BallsDelegate?){
        self.tabMainCellType = tabMainCellType
        self.heightCell = 384.0 //если есть данные в коллекции
        self.ballsDelegate = ballsDelegate
        self.myBallsCellType = .getBalls
    }
    
    init(myBallsCellType: MyBallsCellType, ballsDelegate: BallsDelegate?){
        self.myBallsCellType = .getBalls
        self.heightCell = 384.0 //если есть данные в коллекции
        self.ballsDelegate = ballsDelegate
        self.tabMainCellType = .tabMainBalls
    }
    
    //MARK:- CollectionView
    func numberOfItemsInSection(at section: Int) -> Int {
        return 7
    }
    
    func cellForRow(at indexPath: IndexPath) -> BallsCollectionCellViewModelType {
        return BallsCollectionCellViewModel()
    }
}
