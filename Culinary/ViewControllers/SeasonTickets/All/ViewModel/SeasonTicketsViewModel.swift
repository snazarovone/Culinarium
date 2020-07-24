//
//  SeasonTicketsViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 11.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class SeasonTicketsViewModel{
    
    private var dataSeason = [SeasonModelType]()
    private weak var seasonTCollectionDelegate: SeasonTCollectionDelegate?
    public var sizeCouponsCell: SizeCouponsCell
    public var stateSeasonT: StateSeasonT
    
    init(sizeCouponsCell: SizeCouponsCell, stateSeasonT: StateSeasonT, seasonTCollectionDelegate: SeasonTCollectionDelegate?){
        self.sizeCouponsCell = sizeCouponsCell
        self.stateSeasonT = stateSeasonT
        self.seasonTCollectionDelegate = seasonTCollectionDelegate
        
        let data1 = SeasonTicketsModel(typeSeason: .withTime)
        let data2 = SeasonTicketsModel(typeSeason: .activate)
        let data3 = SeasonTicketsModel(typeSeason: .withTime)
        let data4 = SeasonTicketsModel(typeSeason: .activate)
        let data5 = SeasonTicketsModel(typeSeason: .activate)
        self.dataSeason = [data1, data2, data3, data4, data5]
    }
}

extension SeasonTicketsViewModel: SeasonTicketsViewModelType{
    func numberOfRow(in section: Int) -> Int {
        return dataSeason.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> SeasonTCellDelegate {
        switch dataSeason[indexPath.row].typeSeason{
        case .withTime:
            return SeasonTTimeCellViewModel(sizeCouponsCell: sizeCouponsCell, seasonTicketsModel: dataSeason[indexPath.row] as! SeasonTicketsModel, seasonTCollectionDelegate: seasonTCollectionDelegate)
        case .activate:
            return SeasonTActivateCellViewModel(sizeCouponsCell: sizeCouponsCell, seasonTicketsModel: dataSeason[indexPath.row] as! SeasonTicketsModel, seasonTCollectionDelegate: seasonTCollectionDelegate)
        }
    }
    
}
