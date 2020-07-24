//
//  SeasonTicketsViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 11.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

class SeasonTicketsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewCollectection: UIBarButtonItem!
    @IBOutlet var tumbLine_btns: [UIButtonDesignable]!
    
    //PRIVATE
    private var direction: UICollectionView.ScrollDirection = .horizontal
    private let animator: (LayoutAttributesAnimator, Bool, Int, Int) = (LinearCardAttributesAnimator(minAlpha: 1.0, itemSpacing: 0.26 , scaleRate: 0.83), false, 1, 1)
    private let animator2: (LayoutAttributesAnimator, Bool, Int, Int) = (LinearCardAttributesAnimator(minAlpha: 1.0, itemSpacing: 0.0, scaleRate: 1.0), false, 1, 1)
    private var automaticSize: CGSize!
    private var presentationCollection: ViewCollection = .card
    
    private var seasonTViewModel: SeasonTicketsViewModel!
    private weak var seasonTCollectionDelegate: SeasonTCollectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.seasonTCollectionDelegate = self
        
        automaticSize = CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        
        let sizeCouponsCell = SizeCouponsCell(viewCollection: presentationCollection, size: automaticSize) //card is default
        
        seasonTViewModel = SeasonTicketsViewModel(sizeCouponsCell: sizeCouponsCell, stateSeasonT: .my, seasonTCollectionDelegate: seasonTCollectionDelegate)
   
//        !!!!!!!!!!!!
//        self.couponsViewModel = CouponsViewModel(sizeCouponsCell: sizeCouponsCell, couponsCollectionDelegate: couponsCollectionDelegate, stateCouponsSaved: .online)
//
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
            
            self.seasonTViewModel.sizeCouponsCell = SizeCouponsCell(viewCollection: presentationCollection, size: sizeCell)
        
            if let layout = collectionView.collectionViewLayout as? AnimatedCollectionViewLayout {
                layout.scrollDirection = direction
                layout.animator = animator2.0
            }
        }else{
            presentationCollection = .card
            direction = .horizontal
            collectionView.isPagingEnabled = true
            
            let sizeCell = CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
            
            self.seasonTViewModel.sizeCouponsCell = SizeCouponsCell(viewCollection: presentationCollection, size: sizeCell)
            
            if let layout = collectionView.collectionViewLayout as? AnimatedCollectionViewLayout {
                layout.scrollDirection = direction
                layout.animator = animator.0
            }
        }
        collectionView.reloadData()
    }
    
    //MARK:- Action Online/Offline
    @IBAction func tumbLine(_ sender: UIButton){
        for state in StateSeasonT.allCases{
            if state.tag == sender.tag{
                tumbLine_btns[state.tag].backgroundColor = UIColor(named: "RedA4262A")
                tumbLine_btns[state.tag].setTitleColor(.white, for: .normal)
                tumbLine_btns[state.tag].shadowColor = UIColor(named: "RedA4262A")
                
                self.seasonTViewModel.stateSeasonT = state
                
                var indexUnselected = StateSeasonT.my.tag
                if state == .my{
                    indexUnselected = StateSeasonT.available.tag
                }
                
                tumbLine_btns[indexUnselected].backgroundColor = .white
                tumbLine_btns[indexUnselected].setTitleColor(UIColor(named: "Black282A2F"), for: .normal)
                tumbLine_btns[indexUnselected].shadowColor = UIColor(named: "Black282A2F")
            }
        }
    }
    
    //MARK:- About Tickets
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier,  identifier == SegueID.aboutCoupon.id{
            if let dvc = segue.destination as? AboutCouponsViewController{
                dvc.typeAbout = .seasonTicket
            }
        }
    }
    
    
    //MARK:- deinit
    deinit {
        print("SeasonTickets is deinit")
    }

}

extension SeasonTicketsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.seasonTViewModel.numberOfRow(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = seasonTViewModel.cellForRow(at: indexPath)
        switch cellData.seasonTicketsModel.typeSeason{
        case .withTime:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.seasonTTime.identifire, for: indexPath) as! SeasonTTimeCollectionViewCell
            cell.dataSeasonT = cellData as? SeasonTTimeCellViewModelType
            return cell
        case .activate:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.seasonTActivate.identifire, for: indexPath) as! SeasonTActivateCollectionViewCell
            cell.dataSeasonActivate = cellData as? SeasonTActivateCellViewModelType
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

//MARK:- Action Collection Cell

extension SeasonTicketsViewController: SeasontTicketTimeDelegate{
    func showSeasonTicketTime() {
        performSegue(withIdentifier: SegueID.aboutCoupon.id, sender: nil)
    }
}

extension SeasonTicketsViewController: SeasontTicketActivateDelegate{
    func showSeasontTicketActivate() {
        performSegue(withIdentifier: SegueID.aboutSeasonATicket.id, sender: nil)
    }
}
