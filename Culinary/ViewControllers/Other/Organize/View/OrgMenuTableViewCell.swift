//
//  OrgMenuTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class OrgMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var orgMenuTableViewCellViewModel: OrgMenuTableViewCellViewModel?
    weak var menuDelegate: MenuDelegate?
    
    weak var dataMenu: OrgMenuTableCellViewModelType?{
        willSet(data){
            self.orgMenuTableViewCellViewModel = OrgMenuTableViewCellViewModel(items: data?.items ?? [], selectedIndexPath: data?.selectedItem ?? IndexPath(row: 0, section: 0))
            self.collectionView.reloadData()
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

}

extension OrgMenuTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.orgMenuTableViewCellViewModel?.numberOfRow(in: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = self.orgMenuTableViewCellViewModel!.cellForRow(at: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.feedbackType.identifire, for: indexPath) as! FeedbackTypeCollectionViewCell
        cell.dataFeedback = cellData
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.orgMenuTableViewCellViewModel?.didSelect(at: indexPath)
        menuDelegate?.didSelectMenu(at: indexPath)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = orgMenuTableViewCellViewModel?.getWightTextAt(indexPath: indexPath)
        return CGSize(width: width ?? 100.0, height: 44.0)
    }
}
