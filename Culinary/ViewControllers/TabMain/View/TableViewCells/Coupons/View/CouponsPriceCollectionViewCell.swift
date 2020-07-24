//
//  CouponsPriceCollectionViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 09.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class CouponsPriceCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var pictiteEat: UIImageView!
    @IBOutlet weak var titleDescription: UILabel!
    @IBOutlet weak var sale: UIImageView! //isHidden = true
    @IBOutlet weak var days: UILabel! // 00
    @IBOutlet weak var hour: UILabel! // 00
    @IBOutlet weak var minuts: UILabel! //12
    @IBOutlet weak var seconds: UILabel! //48
    @IBOutlet weak var viewFullTimer: UIViewDesignable!
    @IBOutlet weak var viewShortTimer: UIViewDesignable!
    
    @IBOutlet weak var bottomBtn: NSLayoutConstraint!
    @IBOutlet weak var leadingBtn: NSLayoutConstraint!
    
    // equals 4 on tabMainCoupon, equals 8 on CouponsView
    @IBOutlet weak var titleVerticaleSpace: NSLayoutConstraint!
    
    weak var couponsCollectionDelegate: CouponsCollectionDelegate?
    
    weak var dataCouponsPrice: CouponsPriceCollectionCellViewModelType?{
        willSet(data){
            
            self.couponsCollectionDelegate = data?.couponsCollectionDelegate
            
            if (data?.timeView == true){
                if let viewCollection = data?.viewCollection, viewCollection == .grid{
                    viewShortTimer.isHidden = false
                    viewFullTimer.isHidden = true
                }else{
                    viewShortTimer.isHidden = true
                    viewFullTimer.isHidden = false
                }
            }else{
                viewShortTimer.isHidden = true
                viewFullTimer.isHidden = true
            }
            
            //если представление в виде сетки, ячейки будут маленькими, меням отступы
            if let viewCollection = data?.viewCollection, viewCollection == .grid{
                //ячейки экрана купоны в виде сетки
                bottomBtn.constant = 8.0
                leadingBtn.constant = 8.0
                titleVerticaleSpace.constant = 0.0
            }else{
                if data?.viewCollection == nil{
                    //ячейки на главном табе
                    bottomBtn.constant = 12.0
                    leadingBtn.constant = 12.0
                    titleVerticaleSpace.constant = 4.0
                }else{
                    //ячейки экрана купоны в виде карточек
                    bottomBtn.constant = 24.0
                    leadingBtn.constant = 16.0
                    titleVerticaleSpace.constant = 12.0
                }
            }
        }
    }
    
    @IBAction func priceAction(_ sender: UIButton) {
        couponsCollectionDelegate?.priceAction()
    }
    
}
