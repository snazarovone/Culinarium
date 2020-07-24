//
//  SeasonTActivateCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 11.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class SeasonTActivateCellViewModel: SeasonTActivateCellViewModelType, SeasonTCellDelegate{
  
    var seasontTicketActivateDelegate: SeasontTicketActivateDelegate?
    
    var cellSize: CGSize
    
    var viewCollection: ViewCollection?
    
    var seasonTicketsModel: SeasonTicketsModel
    
    init(seasonTicketsModel: SeasonTicketsModel, seasonTCollectionDelegate: SeasonTCollectionDelegate?){
        self.cellSize = CGSize(width: 200.0, height: 280.0)
        self.seasonTicketsModel = seasonTicketsModel
        self.seasontTicketActivateDelegate = seasonTCollectionDelegate as? SeasontTicketActivateDelegate
    }
    
    init(sizeCouponsCell: SizeCouponsCell, seasonTicketsModel: SeasonTicketsModel, seasonTCollectionDelegate: SeasonTCollectionDelegate?){
        self.cellSize = sizeCouponsCell.size
        self.viewCollection = sizeCouponsCell.viewCollection
        self.seasonTicketsModel = seasonTicketsModel
        self.seasontTicketActivateDelegate = seasonTCollectionDelegate as? SeasontTicketActivateDelegate
    }
}
