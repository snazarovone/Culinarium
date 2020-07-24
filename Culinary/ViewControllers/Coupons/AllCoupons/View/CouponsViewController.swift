//
//  CouponsViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 07.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

class CouponsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewCollectection: UIBarButtonItem!
    @IBOutlet var tumbLine_btns: [UIButtonDesignable]!
    
    //PRIVATE
    private var direction: UICollectionView.ScrollDirection = .horizontal
    private let animator: (LayoutAttributesAnimator, Bool, Int, Int) = (LinearCardAttributesAnimator(minAlpha: 1.0, itemSpacing: 0.26 , scaleRate: 0.83), false, 1, 1)
    private let animator2: (LayoutAttributesAnimator, Bool, Int, Int) = (LinearCardAttributesAnimator(minAlpha: 1.0, itemSpacing: 0.0, scaleRate: 1.0), false, 1, 1)
    private var automaticSize: CGSize!
    private var presentationCollection: ViewCollection = .card
    
    private var couponsViewModel: CouponsViewModel!
    private weak var couponsCollectionDelegate: CouponsCollectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        couponsCollectionDelegate = self
        
        automaticSize = CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)

        let sizeCouponsCell = SizeCouponsCell(viewCollection: presentationCollection, size: automaticSize) //card is default
        
        self.couponsViewModel = CouponsViewModel(sizeCouponsCell: sizeCouponsCell, couponsCollectionDelegate: couponsCollectionDelegate, stateCouponsSaved: .online)
        
        if let layout = collectionView?.collectionViewLayout as? AnimatedCollectionViewLayout {
            layout.scrollDirection = direction
            layout.animator = animator.0
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        super.viewWillAppear(animated)
    }

    //MARK:- View Grid or Card
    @IBAction func presentCollectionCellView(_ sender: UIBarButtonItem) {
        if presentationCollection == .card{
            presentationCollection = .grid
            direction = .vertical
            collectionView.isPagingEnabled = false
            
            let sizeCell = CGSize(width: collectionView.bounds.width / 2.0, height: 270.0)
            
            self.couponsViewModel.sizeCouponsCell = SizeCouponsCell(viewCollection: presentationCollection, size: sizeCell)
            
            if let layout = collectionView.collectionViewLayout as? AnimatedCollectionViewLayout {
                layout.scrollDirection = direction
                layout.animator = animator2.0
            }
        }else{
            presentationCollection = .card
            direction = .horizontal
            collectionView.isPagingEnabled = true
            
            let sizeCell = CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
            
            self.couponsViewModel.sizeCouponsCell = SizeCouponsCell(viewCollection: presentationCollection, size: sizeCell)
            
            if let layout = collectionView.collectionViewLayout as? AnimatedCollectionViewLayout {
                layout.scrollDirection = direction
                layout.animator = animator.0
            }
        }
        collectionView.reloadData()
    }
    
    //MARK:- Action Online/Offline
    @IBAction func tumbLine(_ sender: UIButton){
        for state in StateCouponsSaved.allCases{
            if state.tag == sender.tag{
                tumbLine_btns[state.tag].backgroundColor = UIColor(named: "RedA4262A")
                tumbLine_btns[state.tag].setTitleColor(.white, for: .normal)
                tumbLine_btns[state.tag].shadowColor = UIColor(named: "RedA4262A")
                
                self.couponsViewModel.stateCouponsSaved = state
                
                var indexUnselected = StateCouponsSaved.online.tag
                if state == .online{
                    indexUnselected = StateCouponsSaved.offline.tag
                }
                
                tumbLine_btns[indexUnselected].backgroundColor = .white
                tumbLine_btns[indexUnselected].setTitleColor(UIColor(named: "Black282A2F"), for: .normal)
                tumbLine_btns[indexUnselected].shadowColor = UIColor(named: "Black282A2F")
            }
        }
    }
    
    //MARK:- deinit
    deinit{
        print("CouponsViewController is deinit")
    }
}

extension CouponsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return couponsViewModel.numberOfRowInSectiom(at: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = couponsViewModel.cellForRow(at: indexPath)
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
        if presentationCollection == .card{
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        }else{
            return CGSize(width: collectionView.bounds.width / 2.0, height: 270.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if presentationCollection == .card{
            return .zero
        }else{
            return 24.0
        }
    }
}


//MARK:- Collection Cell Action
extension CouponsViewController: CouponsCollectionDelegate{
    func logout() {
    }
    
    func aboutAction() {
        performSegue(withIdentifier: SegueID.aboutCoupon.id, sender: nil)
    }
    
    func priceAction() {
        performSegue(withIdentifier: SegueID.aboutCoupon.id, sender: nil)
    }
    
}
