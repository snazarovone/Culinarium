//
//  CouponsTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class CouponsTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var countCoupons: UILabel! //in ()
    
    private weak var couponsDelegate: CouponsDelegate?
    
    weak var dataCoupons: CouponsTableCellViewModelType?{
        willSet(data){
            self.couponsDelegate = data?.couponsDelegate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @IBAction func all(_ sender: UIButton) {
        self.couponsDelegate?.showCoupons()
    }
}

//MARK:- CollectionView
extension CouponsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataCoupons?.numberOfItemsInSection(at: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = self.dataCoupons!.cellForRow(at: indexPath)
        switch cellData.couponsModel.typeCell{
        case .about:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  CellID.couponsAbout.identifire, for: indexPath) as! CouponsCollectionViewCell
            cell.dataCoupons = cellData as? CouponsCollectionCellViewModelType
            return cell
        case .price:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  CellID.couponsPrice.identifire, for: indexPath) as! CouponsPriceCollectionViewCell
            cell.dataCouponsPrice = cellData as? CouponsPriceCollectionCellViewModelType
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dataCell = self.dataCoupons!.cellForRow(at: indexPath)
        return dataCell.cellSize
    }
}
