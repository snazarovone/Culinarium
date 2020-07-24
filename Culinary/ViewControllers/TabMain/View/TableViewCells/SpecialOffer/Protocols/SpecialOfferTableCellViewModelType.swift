//
//  SpecialOfferTableCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol SpecialOfferTableCellViewModelType: class {
    func numberOfItemsInSection(at section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> SpecialOfferCollectionCellViewModelType
    
    var specialOfferDelegate: SpecialOfferDelegate? {get}
}
