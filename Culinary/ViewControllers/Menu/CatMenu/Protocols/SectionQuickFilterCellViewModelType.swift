//
//  SectionQuickFilterCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol SectionQuickFilterCellViewModelType: class {
    var cash_payment: QuickFilters {get}
    var express_delivery: QuickFilters {get}
    var discount: QuickFilters {get}
}
