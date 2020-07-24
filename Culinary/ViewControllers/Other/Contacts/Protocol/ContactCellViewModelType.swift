//
//  ContactCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 09.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol ContactCellViewModelType: class {
    var name: String {get}
    var description: String? {get}
    var mail: String? {get}
    var phone: String? {get}
    var isHiddenMail: Bool {get}
    var isHiddenPhone: Bool {get}
}
