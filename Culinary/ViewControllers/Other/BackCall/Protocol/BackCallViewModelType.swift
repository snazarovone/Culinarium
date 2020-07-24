//
//  BackCallViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol BackCallViewModelType {
    func formattedNumber(number: String) -> String
    var name: String? {get}
    var phoneUser: String? {get}
}
