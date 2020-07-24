//
//  AboutOrderViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 14.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol AboutOrderViewModelType {
    func numberOfRow() -> Int
    func cellForRow(at indexPath: IndexPath) -> AboutOrderType
    
    var numberOrder: String {get}
    var position: String {get}
}
