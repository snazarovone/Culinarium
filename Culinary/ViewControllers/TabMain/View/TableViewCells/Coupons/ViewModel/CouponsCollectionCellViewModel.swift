//
//  CouponsCollectionCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class CouponsCollectionCellViewModel: CouponsCellDelegate, CouponsCollectionCellViewModelType{
   
    var viewCollection: ViewCollection?
    var cellSize: CGSize
    var couponsModel: CouponsModel
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
