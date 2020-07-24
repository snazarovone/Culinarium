//
//  SectionQuickFilterCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

class SectionQuickFilterCellViewModel: SectionQuickFilterCellViewModelType{
    var cash_payment: QuickFilters
    
    var express_delivery: QuickFilters
    
    var discount: QuickFilters
    
    
    init(cash_payment: QuickFilters, express_delivery: QuickFilters, discount: QuickFilters){
        self.cash_payment = cash_payment
        self.express_delivery = express_delivery
        self.discount = discount
    }
}
