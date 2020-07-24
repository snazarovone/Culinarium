//
//  BallsTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BallsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private weak var ballsDelegate: BallsDelegate?
    
    weak var dataBalls: BallsTableCellViewModelType?{
        willSet(data){
            self.ballsDelegate = data?.ballsDelegate
        }
    }
    
    @IBAction func all(_ sender: UIButton) {
        dataBalls?.ballsDelegate?.showEarnBalls()
    }
    
}

extension BallsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataBalls?.numberOfItemsInSection(at: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.tabMainBalls.identifire, for: indexPath) as! BallsCollectionViewCell
        cell.dataBalls = dataBalls!.cellForRow(at: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dataCell = self.dataBalls!.cellForRow(at: indexPath)
        return dataCell.cellSize
    }
}
