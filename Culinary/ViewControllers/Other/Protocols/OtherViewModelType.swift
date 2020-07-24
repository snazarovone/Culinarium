//
//  OtherViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 26.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol OtherViewModelType{
    func numberOfRow(in section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> OtherModelType
    func didSelect(at indexPath: IndexPath) -> OtherModelType
}
