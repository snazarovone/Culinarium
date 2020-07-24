//
//  CatMenuBottomViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 15.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RxSwift
import RxCocoa

class CatMenuBottomViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //PUBLIC
    public var pageIndex: Int = 0
    public var pageTitle: String?
    
    public var catMenuBottomViewModel: CatMenuBottomViewModel?
    public weak var catMenuMainDelegate: CatMenuMainDelegate?
    public var favoritesDish: BehaviorRelay<MenuSectionsModel?> = BehaviorRelay(value: nil)

    
    //PRIVATE
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribes()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == SegueID.aboutDishMain.id{
            if let dvc = segue.destination as? DishMainViewController{
                dvc.dish = sender as? DisheModel
                dvc.catMenuMainDelegate = catMenuMainDelegate
                dvc.favoritesDish = favoritesDish
            }
            return
        }
    }
    
    private func subscribes(){
        favoritesDish.asObservable().subscribe(onNext: { [weak self] (value) in
            guard let value = value else {return}
            //обновит данные
            self?.catMenuBottomViewModel?.updateDishes(favorites: value)
            self?.catMenuBottomViewModel?.dishesAtQuickFilters()
            self?.collectionView.reloadData()
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    

    //MARK:- deinit
    deinit{
        print("CatMenuBottomViewController is deinit")
    }
}

extension CatMenuBottomViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        return catMenuBottomViewModel?.numberOfRow() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.sectionQuickFilter.identifire, for: indexPath) as! SectionQuickFilterCollectionViewCell
            cell.quickFiltersDelegate = self
            cell.dataSectionQuickFilter = self.catMenuBottomViewModel?.cellForRow()
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.catMenu.identifire, for: indexPath) as! CatMenuCollectionViewCell
            cell.dataCatMenu = catMenuBottomViewModel!.cellForRow(at: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: (collectionView.frame.size.width - 24.0), height:  80.0)
        }else{
            var columns: Int = 2
            columns = Int(collectionView.frame.size.width / 320) + 1
            let w = ((collectionView.frame.size.width - 24.0) / CGFloat(columns)) - CGFloat(6*(columns-1))
            let h = w * 1.5308642
            return CGSize(width: w, height: h)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            if let dish = self.catMenuBottomViewModel?.getDish(at: indexPath){
                self.performSegue(withIdentifier: SegueID.aboutDishMain.id, sender: dish)
            }
        }
    }
        
}

extension CatMenuBottomViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: pageTitle ?? "Tab \(pageIndex)")
    }
}


extension CatMenuBottomViewController: QuickFiltersDelegate{
    func quickFilter(filter: QuickFilters) {
        switch filter {
        case .cash_payment, .not_cash_payment:
            self.catMenuBottomViewModel?.cash_payment = filter
        case .express_delivery, .not_express_delivery:
            self.catMenuBottomViewModel?.express_delivery = filter
        case .discount, .not_discount:
            self.catMenuBottomViewModel?.discount = filter
        }
        self.catMenuBottomViewModel?.dishesAtQuickFilters()
        self.collectionView.reloadData()
    }
}

