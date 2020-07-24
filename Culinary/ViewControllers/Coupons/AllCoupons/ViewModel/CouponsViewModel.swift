//
//  CouponsViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 09.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation
import UIKit

class CouponsViewModel{
    
    private var dataCoupons = [CouponsModel]()
    public var sizeCouponsCell: SizeCouponsCell
    private weak var couponsCollectionDelegate: CouponsCollectionDelegate?
    public var stateCouponsSaved: StateCouponsSaved
    
    init(sizeCouponsCell: SizeCouponsCell, couponsCollectionDelegate: CouponsCollectionDelegate?, stateCouponsSaved: StateCouponsSaved) {
        self.sizeCouponsCell = sizeCouponsCell
        self.couponsCollectionDelegate = couponsCollectionDelegate
        self.stateCouponsSaved = stateCouponsSaved
        
        let coupon1 = CouponsModel(typeCell: .price, timeView: true)
        let coupon2 = CouponsModel(typeCell: .price, timeView: false)
        let coupon3 = CouponsModel(typeCell: .about, timeView: true)
        let coupon4 = CouponsModel(typeCell: .about, timeView: false)
        
        self.dataCoupons = [coupon1, coupon2, coupon3, coupon4, coupon1, coupon2, coupon3, coupon4, coupon1, coupon2, coupon3, coupon4]
    }
}

extension CouponsViewModel: CouponsViewModelType{
    func numberOfRowInSectiom(at indexPath: Int) -> Int {
        return dataCoupons.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> CouponsCellDelegate {
        switch dataCoupons[indexPath.row].typeCell{
        case .about:
            return CouponsCollectionCellViewModel(sizeCouponsCell: sizeCouponsCell, couponsModel: dataCoupons[indexPath.row], couponsDelegate: couponsCollectionDelegate)
        case .price:
            return CouponsPriceCollectionCellViewModel(sizeCouponsCell: sizeCouponsCell, couponsModel: dataCoupons[indexPath.row],  couponsDelegate: couponsCollectionDelegate)
        }
    }
}
