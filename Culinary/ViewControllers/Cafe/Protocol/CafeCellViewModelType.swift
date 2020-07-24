//
//  CafeCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 21.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol CafeCellViewModelType: class {
    var imgUrl: String? {get}
    var titleCafe: String? {get}
    var addressCafe: String? {get}
    var distanceCafe: String? {get}
    var openedTime: String? {get}
    var nearest: Bool? {get}
}
