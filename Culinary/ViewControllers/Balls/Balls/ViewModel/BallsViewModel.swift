//
//  BallsViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 07.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class BallsViewModel: BallsViewModelType{
    
    private var ballsEarnCell: [BallsEarnModel]!
   
    init(ballsDelegate: BallsEarnDelegate?){
        let feedbackCell = BallsEarnModel(ballsEarnCellType: .feedback, ballsDelegate: ballsDelegate)
        let shareCell = BallsEarnModel(ballsEarnCellType: .share, ballsDelegate: ballsDelegate)
        let buyerCell = BallsEarnModel(ballsEarnCellType: .buyer, ballsDelegate: ballsDelegate)
        let profileCell = BallsEarnModel(ballsEarnCellType: .profile, ballsDelegate: ballsDelegate)
        self.ballsEarnCell = [feedbackCell, shareCell, buyerCell, profileCell]
    }
    
    func numberOfRowsInSection(at section: Int) -> Int {
        return ballsEarnCell.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> BallsEarnModelType{
        switch ballsEarnCell[indexPath.row].ballsEarnCellType {
        case .feedback:
            return BallsFeedbackCellViewModel(ballsEarnModel:  ballsEarnCell[indexPath.row])
        case .share:
            return BallsShareCellViewModel(ballsEarnModel: ballsEarnCell[indexPath.row])
        case .buyer:
            return BallsBuyerCellViewModel(ballsEarnModel: ballsEarnCell[indexPath.row])
        case .profile:
            return BallsProfileCellViewModel(ballsEarnModel: ballsEarnCell[indexPath.row])
        }
    }
}
