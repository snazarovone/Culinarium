//
//  SeasonTicketsTableCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class SeasonTicketsTableCellViewModel: TabMainTableCellType, SeasonTicketsTableViewCellType{
    
    var tabMainCellType: TabMainCellType
    var heightCell: CGFloat
    weak var seasonTicketDelegate: SeasonTicketDelegate?
    weak var seasonTCollectionDelegate: SeasonTCollectionDelegate?
    
    private var dataSeason = [SeasonModelType]()
    
    init(tabMainCellType: TabMainCellType, seasonTicketDelegate: SeasonTicketDelegate, seasonTCollectionDelegate: SeasonTCollectionDelegate?){
        self.tabMainCellType = tabMainCellType
        self.heightCell = 360.0 //если есть данные в коллекции
        self.seasonTicketDelegate = seasonTicketDelegate
        self.seasonTCollectionDelegate = seasonTCollectionDelegate
        
        let data1 = SeasonTicketsModel(typeSeason: .withTime)
        let data2 = SeasonTicketsModel(typeSeason: .activate)
        let data3 = SeasonTicketsModel(typeSeason: .withTime)
        let data4 = SeasonTicketsModel(typeSeason: .activate)
        let data5 = SeasonTicketsModel(typeSeason: .activate)
        self.dataSeason = [data1, data2, data3, data4, data5]
    }
    
    //MARK:- CollectionView

    func numberOfRow(in section: Int) -> Int {
        return dataSeason.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> SeasonTCellDelegate {
        switch dataSeason[indexPath.row].typeSeason{
        case .withTime:
            return  SeasonTTimeCellViewModel(seasonTicketsModel: dataSeason[indexPath.row] as! SeasonTicketsModel, seasonTCollectionDelegate: seasonTCollectionDelegate)
        case .activate:
            return SeasonTActivateCellViewModel(seasonTicketsModel: dataSeason[indexPath.row] as! SeasonTicketsModel, seasonTCollectionDelegate: seasonTCollectionDelegate)
        }
    }
    
}
