//
//  FavoritesViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var collectionViewFilter: UICollectionView!
    @IBOutlet weak var collectionViewFavorites: UICollectionView!
    
    //PRIVATE
    public var favoritesViewModel: FavoritesViewModel!
    private let disposeBag = DisposeBag()
    
    //PUBLIC
    public weak var catMenuMainDelegate: CatMenuMainDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()
        subscribes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func subscribes(){
        favoritesViewModel.favoritesDish.asObservable().skip(1).subscribe(onNext: { [weak self] (value) in
            guard value != nil else {return}
            //обновит данные
            self?.favoritesViewModel.updateSection()
            self?.collectionViewFilter.reloadData()
            self?.collectionViewFavorites.reloadData()
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    //MARK:- Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == SegueID.aboutDishMain.id{
            if let dvc = segue.destination as? DishMainViewController{
                dvc.dish = sender as? DisheModel
                dvc.catMenuMainDelegate = self.catMenuMainDelegate
                dvc.favoritesDish = favoritesViewModel.favoritesDish
            }
            return
        }
    }
    
    
    //MARK:- Actions
    @IBAction func back(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    

    //MARK:- deinit
    deinit{
        print("FavoritesViewController is deinit")
    }
}

//MARK:- Collection
extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionViewFilter == collectionView{
            return self.favoritesViewModel.numberOfRowInSection()
        }else{
            return self.favoritesViewModel.numberOfRowInSectionCollectionEat()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionViewFilter == collectionView{
            let cellData = favoritesViewModel.cellForRow(at: indexPath)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.favoriteFilterAll.identifire, for: indexPath) as! FavoriteFilterAllCollectionViewCell
            cell.dataFilterAll = cellData
            return cell
        }else{
            let cellData = favoritesViewModel.cellForRowCollectionEat(at: indexPath)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.favoriteEat.identifire, for: indexPath) as! FavoriteEatCollectionViewCell
            cell.dataFavoritesEat = cellData
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionViewFilter == collectionView{
            let width = favoritesViewModel.getWightTextAt(indexPath: indexPath) + 24
            return CGSize(width: width, height: 44.0)
        }else{
            return CGSize(width: 163.0, height: 252.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionViewFilter{
            self.favoritesViewModel.didSelectFilter(at: indexPath)
            self.collectionViewFilter.reloadData()
            self.collectionViewFavorites.reloadData()
        }else{
            DispatchQueue.main.async {
                if let dish = self.favoritesViewModel.getDish(at: indexPath){
                    self.performSegue(withIdentifier: SegueID.aboutDishMain.id, sender: dish)
                }
            }
        }
    }
}

