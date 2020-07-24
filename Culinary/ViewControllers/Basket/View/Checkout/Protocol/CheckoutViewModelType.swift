//
//  CheckoutViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 17.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import UIKit

protocol CheckoutViewModelType{
    func formattedNumber(number: String) -> String
    func numberOfRow() -> Int
    func cellForRow(at indexPath: IndexPath) -> SaveAddressCellViewModelType
    func didSelect(at indexPath: IndexPath)
    var heightListMyAddress: CGFloat {get}
    
    var titleSelectAddress: String? {get}
    var street: String? {get}
    var house: String? {get}
    var floor: String? {get}
    var flat: String? {get}
    var porch: String? {get}
    var doorcode: String? {get}
    var idSelectedAddress: Int? {get}
    func removeSelectedAddress()
    func checkExistSelectedAddress() -> Bool
    func nameSelectCafe() -> String?
    func getAuth() -> ErrorAuth?
}
