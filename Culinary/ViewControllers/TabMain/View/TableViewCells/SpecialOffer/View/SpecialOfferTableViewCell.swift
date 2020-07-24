//
//  SpecialOfferTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class SpecialOfferTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var specialOfferDelegate: SpecialOfferDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    weak var dataSpecialOffer: SpecialOfferTableCellViewModelType?{
        willSet(data){
            self.specialOfferDelegate = data?.specialOfferDelegate
        }
    }
    
    @IBAction func all(_ sender: UIButton) {
        specialOfferDelegate?.allSpecialOffer()
    }
}

extension SpecialOfferTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSpecialOffer?.numberOfItemsInSection(at: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.tabMainSpecialOffer.identifire, for: indexPath) as! SpecialOfferCollectionViewCell
        cell.dataSpecialOffer = self.dataSpecialOffer!.cellForRow(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dataCell = self.dataSpecialOffer!.cellForRow(at: indexPath)
        return dataCell.cellSize
    }
}
