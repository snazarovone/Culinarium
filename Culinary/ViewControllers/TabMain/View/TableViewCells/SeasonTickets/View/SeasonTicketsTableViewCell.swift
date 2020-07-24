//
//  SeasonTicketsTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class SeasonTicketsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var countSeasonTickents: UILabel! //in ()
    
    weak var seasonTicketDelegate: SeasonTicketDelegate?
    
    weak var dataSeasonTickets: SeasonTicketsTableViewCellType?{
        willSet(data){
            self.seasonTicketDelegate = data?.seasonTicketDelegate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @IBAction func all(_ sender: UIButton) {
        seasonTicketDelegate?.showAllSeasonTicket()
    }
}

//MARK:- CollectionView
extension SeasonTicketsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSeasonTickets?.numberOfRow(in: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = dataSeasonTickets!.cellForRow(at: indexPath)
        switch cellData.seasonTicketsModel.typeSeason{
        case .withTime:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.seasonTTime.identifire, for: indexPath) as! SeasonTTimeCollectionViewCell
            cell.dataSeasonT = cellData as? SeasonTTimeCellViewModelType
            return cell
        case .activate:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.seasonTActivate.identifire, for: indexPath) as! SeasonTActivateCollectionViewCell
            cell.dataSeasonActivate = cellData as? SeasonTActivateCellViewModelType
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dataCell = self.dataSeasonTickets!.cellForRow(at: indexPath)
        return dataCell.cellSize
    }
}
