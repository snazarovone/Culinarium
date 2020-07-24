//
//  CouponsViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 09.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol CouponsViewModelType{
    func numberOfRowInSectiom(at section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> CouponsCellDelegate
}
