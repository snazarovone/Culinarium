//
//  TabMainViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TabMainViewModel: TabMainViewModelType{
    
    private var dataTableView = [TabMainTableCellType]()
    private var favoritesDish: BehaviorRelay<MenuSectionsModel?> = BehaviorRelay(value: nil)
    
    init(tabMainDelegate: TabMainDelegate?, seasonTCollectionDelegate: SeasonTCollectionDelegate?, favoritesDish: BehaviorRelay<MenuSectionsModel?>, stocks: BehaviorRelay<StocksModel?>){
        self.favoritesDish = favoritesDish
        
        let stockCell = StocksTableCellViewModel(tabMainCellType: .tabMainCellStocks, tabMainDelegate: tabMainDelegate, stocks: stocks)
        let seasonTicketCell = SeasonTicketsTableCellViewModel(tabMainCellType: .tabMainSeasonTickets, seasonTicketDelegate: tabMainDelegate as! SeasonTicketDelegate, seasonTCollectionDelegate: seasonTCollectionDelegate)
        let couponsCell = CouponsTableCellViewModel(tabMainCellType: .tabMainCoupons, tabMainDelegate: tabMainDelegate)
        let ballsCell = BallsTableCellViewModel(tabMainCellType: .tabMainBalls, ballsDelegate: tabMainDelegate as? BallsDelegate)
        let specialOfferCell = SpecialOfferTableCellViewModel(tabMainCellType: .tabMainSpecialOffer, specialOfferDelegate: tabMainDelegate as? SpecialOfferDelegate)
        let favoritesCell = FavoritesTableCellViewModel(tabMainCellType: .tabMainFavorites, tabMainDelegate: tabMainDelegate, favoritesDish: favoritesDish)
        let hitCell = HitTableCellViewModel(tabMainCellType: .tabMainHit)
        let joinInCell = JoinInTableCellViewModel(tabMainCellType: .tabMainJoinIn)
        dataTableView = [stockCell, seasonTicketCell, couponsCell, ballsCell, specialOfferCell, favoritesCell, hitCell, joinInCell]
    }
    
    //MARK:-TableView
    func numberOfRowsInSection(at section: Int) -> Int {
        return dataTableView.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> TabMainTableCellType { 
        return dataTableView[indexPath.row]
    }
}
