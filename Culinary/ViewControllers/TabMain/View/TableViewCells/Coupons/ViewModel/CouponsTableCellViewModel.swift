//
//  CouponsTableCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class CouponsTableCellViewModel: TabMainTableCellType, BasketModelType, CouponsTableCellViewModelType{
    
    var basketCellType: BasketCellType{
        return .coupons
    }
    
    var tabMainCellType: TabMainCellType
    var heightCell: CGFloat
    weak var couponsDelegate: CouponsDelegate?
    
    private var dataCoupons = [CouponsModel]()
    
    init(tabMainCellType: TabMainCellType, tabMainDelegate: TabMainDelegate?){
        self.tabMainCellType = tabMainCellType
        self.heightCell = 396.0 //если есть данные в коллекции
        self.couponsDelegate = tabMainDelegate as? CouponsDelegate
        
        let coupon1 = CouponsModel(typeCell: .price, timeView: true)
        let coupon2 = CouponsModel(typeCell: .price, timeView: false)
        let coupon3 = CouponsModel(typeCell: .about, timeView: true)
        let coupon4 = CouponsModel(typeCell: .about, timeView: false)
        
        self.dataCoupons = [coupon1, coupon2, coupon3, coupon4]
    }
    
    //MARK:- CollectionView
    func numberOfItemsInSection(at section: Int) -> Int {
        return dataCoupons.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> CouponsCellDelegate {
        switch dataCoupons[indexPath.row].typeCell{
        case .about:
            return CouponsCollectionCellViewModel(couponsModel: dataCoupons[indexPath.row], couponsDelegate: couponsDelegate)
        case .price:
            return CouponsPriceCollectionCellViewModel(couponsModel: dataCoupons[indexPath.row], couponsDelegate: couponsDelegate)
        }
    }
}
