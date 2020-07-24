//
//  DeliveryInfoViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 08.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol DeliveryInfoViewModelType{
    func cellForRow(at indexPath: IndexPath) -> DeliveryInfoModelType
    func numberRow(of section: Int) -> Int
}
