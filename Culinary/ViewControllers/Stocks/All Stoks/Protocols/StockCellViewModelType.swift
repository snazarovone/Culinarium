//
//  StockCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol StockCellViewModelType: class{
    var titleVC: String {get}
    var image: String? {get}
    var titleStock: String? {get}
    var date_end: Date? {get} //for timer
    var description: String? {get}
    var id: Int? {get}
    var coupon_code: String? {get}
    
}
