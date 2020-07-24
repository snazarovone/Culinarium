//
//  CouponsPriceCollectionCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 09.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class CouponsPriceCollectionCellViewModel: CouponsCellDelegate, CouponsPriceCollectionCellViewModelType{
   
    var couponsModel: CouponsModel
    var viewCollection: ViewCollection?
    var cellSize: CGSize
    weak var couponsCollectionDelegate: CouponsCollectionDelegate?
    
    init(couponsModel: CouponsModel, couponsDelegate: CouponsDelegate?){
        self.cellSize = CGSize(width: 200.0, height: 296.0)
        self.couponsModel = couponsModel
        self.couponsCollectionDelegate = couponsDelegate as? CouponsCollectionDelegate
    }
    
    init(sizeCouponsCell: SizeCouponsCell, couponsModel: CouponsModel, couponsDelegate: CouponsCollectionDelegate?){
        self.cellSize = sizeCouponsCell.size
        self.viewCollection = sizeCouponsCell.viewCollection
        self.couponsModel = couponsModel
        self.couponsCollectionDelegate = couponsDelegate
    }
    
    var timeView: Bool{
        return couponsModel.timeView
    }
}
