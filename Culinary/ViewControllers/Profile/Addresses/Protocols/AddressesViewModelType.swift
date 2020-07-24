//
//  AddressesViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol AddressesViewModelType{
    func numberOfRow(in section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> AddressCellViewModelType
    func removeAddress(at indexPAth: IndexPath)
    func getAuth() -> ErrorAuth?
}
