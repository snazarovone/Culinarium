//
//  OrgSlideShowTableCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class OrgSlideShowTableCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //PRIVATE
    private var orgSlideCollectionViewModel: OrgSlideCollectionViewModel?
    weak var slideShowDelegate: SlideShowDelegate?
    
    weak var dataSlideShow: OrgSlideShowTableCellViewModelType?{
        willSet(data){
            self.orgSlideCollectionViewModel = OrgSlideCollectionViewModel(items: [])
            self.collectionView.reloadData()
            pageControl.numberOfPages = data?.countItems ?? 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pageControl.currentPage = 0
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension OrgSlideShowTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orgSlideCollectionViewModel?.numberOfRow(in: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.orgSlideCollection.identifire, for: indexPath) as! OrgSlideCollectionViewCell
        cell.dataSlide = orgSlideCollectionViewModel!.cellForRow(at: indexPath)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 320.0, height: 168.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
}

extension OrgSlideShowTableCell: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/320.0)
        pageControl.currentPage = Int(pageIndex)
        orgSlideCollectionViewModel?.changePage(at: Int(pageIndex))
        slideShowDelegate?.didChangePage(at: Int(pageIndex))
    }
}
