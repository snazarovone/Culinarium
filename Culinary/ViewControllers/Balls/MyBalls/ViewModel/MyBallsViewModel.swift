//
//  MyBallsViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class MyBallsViewModel{
    
    private var dataMyBalls = [MyBallsType]()
    private weak var myBallsDelegate: MyBallsDelegate?
    
    init(ballsDelegate: BallsDelegate?, myBallsDelegate: MyBallsDelegate?){
        self.myBallsDelegate = myBallsDelegate
        
        let myBonusCell = MyBallsMyBonusModel(myBallsCellType: .myBonus)
        let historyCell = MyBallsHistoryModel(myBallsCellType: .history)
        let getBallCell = BallsTableCellViewModel(myBallsCellType: .getBalls, ballsDelegate: ballsDelegate)
        let actionsCell = MyBallsAction(myBallsCellType: .actions)
        dataMyBalls = [myBonusCell, historyCell, getBallCell, actionsCell]
    }
}

extension MyBallsViewModel: MyBallsViewModelType{
    func numberOfRow(in section: Int) -> Int {
        return dataMyBalls.count
    }

    func cellForRow(at indexPath: IndexPath) -> MyBallsType {
        switch dataMyBalls[indexPath.row].myBallsCellType{
        case .myBonus:
            return MyBonusCellViewModel(myBallsType: dataMyBalls[indexPath.row], delegate: myBallsDelegate)
        case .history:
            return MyBallsHistoryCellViewModel(myBallsType: dataMyBalls[indexPath.row])
        case .getBalls:
            return dataMyBalls[indexPath.row]
        case .actions:
            return MyBallsActionsCellViewModel(myBallsType: dataMyBalls[indexPath.row])
        }
    }
}
