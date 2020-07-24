//
//  BMenuItemTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 23.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BMenuItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var bMenuItemTableViewCellViewModel : BMenuItemTableViewCellViewModel?
    public weak var menuDelegate: MenuDelegate?
    
    weak var dataMenu: BMenuTableCellViewModelType? {
        willSet(data){
            bMenuItemTableViewCellViewModel = BMenuItemTableViewCellViewModel(itemsMenu: data?.itemsMenu  ?? [], selectIndexPath: data?.currentIndex ?? IndexPath(row: 0, section: 0))
            collectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    deinit {
        print("BMenuItemTableViewCell is deinit")
    }
}

extension BMenuItemTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bMenuItemTableViewCellViewModel?.numberOfRow() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.basketMenuItemCollection.identifire, for: indexPath) as! BMenuItemCollectionViewCell
        
        cell.dataMenuCollection = bMenuItemTableViewCellViewModel!.cellForRow(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.bMenuItemTableViewCellViewModel!.didSelect(at: indexPath)
        menuDelegate?.didSelectMenu(at: indexPath)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = bMenuItemTableViewCellViewModel!.getWightTextAt(indexPath: indexPath)
        return CGSize(width: w, height: 44.0)
    }
    
}
