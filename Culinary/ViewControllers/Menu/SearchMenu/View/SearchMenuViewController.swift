//
//  SearchMenuViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 17.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchMenuViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    public var searchMenuViewModel: SearchMenuViewModel!
    public weak var catMenuMainDelegate: CatMenuMainDelegate?
    public var favoritesDish: BehaviorRelay<MenuSectionsModel?> = BehaviorRelay(value: nil)
    //данные для передачи экрану создания отзывов
    public var dishesMainInfo: BehaviorRelay<[DishMainInfo]> = BehaviorRelay(value: [])
    public var listCafe: BehaviorRelay<CafeModel?> = BehaviorRelay(value: nil)
    public var userInfo: BehaviorRelay<UserInfo?> = BehaviorRelay(value: UserInfo())
    
    
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //MARK:- Show About Dish
        if let identifier = segue.identifier, identifier == SegueID.aboutDishMain.id{
            if let dvc = segue.destination as? DishMainViewController{
                dvc.dish = sender as? DisheModel
                dvc.catMenuMainDelegate = self.catMenuMainDelegate
                dvc.favoritesDish = favoritesDish
            }
            return
        }
    }
    
    //MARK:- Subscribes Rx
    private func subscribes(){
        favoritesDish.asObservable().subscribe(onNext: { [weak self] (value) in
            guard let value = value else {return}
            //обновит данные
            self?.searchMenuViewModel?.updateDishes(favorites: value)
            self?.collectionView.reloadData()
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    
    

    //MARK:- deinit
    deinit{
        print("SearchMenuViewController is deinit")
    }
}

extension SearchMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchMenuViewModel.numberOfRow()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.catMenu.identifire, for: indexPath) as! CatMenuCollectionViewCell
        cell.dataCatMenu = searchMenuViewModel.cellForRow(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var columns: Int = 2
        columns = Int(collectionView.frame.size.width / 320) + 1
        let w = ((collectionView.frame.size.width - 24.0) / CGFloat(columns)) - CGFloat(6*(columns-1))
        let h = w * 1.5308642
        return CGSize(width: w, height: h)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: SegueID.aboutDishMain.id, sender: self.searchMenuViewModel.getDish(at: indexPath))
        }
    }
}

