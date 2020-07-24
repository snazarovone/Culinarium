//
//  ListCafeCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 21.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol ListCafeCellViewModelType: class {
    var address: String? {get}
    var nameCafe: String? {get}
    var timeWork: String? {get}
    var phoneNumber: String? {get}
    var metroCIrcle: UIColor? {get}
    var metroStateTitle: String? {get}
    var distance: String? {get}
}
