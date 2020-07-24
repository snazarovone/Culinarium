//
//  FavoritesTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FavoritesTableViewCell: UITableViewCell{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var favoritesDelegate: FavoritesDelegate?
    
    var favoritesDish: BehaviorRelay<MenuSectionsModel?> = BehaviorRelay(value: nil)
    private let disposeBag = DisposeBag()
    
    weak var dataFovorites: FavoritesTableCellViewModelType?{
        willSet(data){
            self.favoritesDelegate = data?.favoritesDelegate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        subscribes()
    }
    
    public func subscribes(){
        favoritesDish.asObservable().subscribe(onNext: { [weak self] (_) in
            self?.collectionView.reloadData()
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    
    @IBAction func all(_ sender: UIButton) {
        self.favoritesDelegate?.showAll()
    }
    
}

extension FavoritesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataFovorites?.numberOfItemsInSection(at: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.tabMainFavorites.identifire, for: indexPath) as! FavoritesCollectionViewCell
        cell.dataFavorites = dataFovorites!.cellForRow(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dataCell = dataFovorites!.cellForRow(at: indexPath)
        return dataCell.cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dish = dataFovorites?.didSelect(at: indexPath) else {return}
        favoritesDelegate?.showAboutFavoriteDish(dish: dish)
    }
}
