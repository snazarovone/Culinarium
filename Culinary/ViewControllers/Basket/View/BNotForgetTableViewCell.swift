//
//  BNotForgetTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BNotForgetTableViewCell: UITableViewCell {

    @IBOutlet weak var titleNotForget: UILabel!
    @IBOutlet weak var countFree: UILabelDesignable!
    @IBOutlet weak var hightCountFreeV: NSLayoutConstraint! //24
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var heightCollectionView: NSLayoutConstraint! //264
    
    
    private var bNotForgetTableViewCellViewModel: BNotForgetTableViewCellViewModel?
    
    weak var dataNotForget: BNotForgetCellViewModelType?{
        willSet(data){
            titleNotForget.text = data?.titleNotForget
            countFree.text = data?.countFree
            hightCountFreeV.constant = data?.hightCountFreeV ?? 0.0
            self.bNotForgetTableViewCellViewModel = BNotForgetTableViewCellViewModel(dataDish: data?.dish ?? [])
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension BNotForgetTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bNotForgetTableViewCellViewModel?.numberOfRow() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.bNotForgetDishCollectionView.identifire, for: indexPath) as! BNotForgetDishCollectionViewCell
        cell.dataCell = bNotForgetTableViewCellViewModel!.cellForRow(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 128.0, height: 264.0)
    }
    
}
