//
//  AddressCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol AddressCellViewModelType: class{
    
    var address : String? {get}
    var isSelect : Bool {get}
    var titleAddress: String? {get}
    var indexPath: IndexPath {get}
    var delegateAddress: AddressActionDelegate? {get}
}
