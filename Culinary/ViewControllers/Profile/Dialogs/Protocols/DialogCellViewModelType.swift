//
//  DialogCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 12.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol DialogCellViewModelType: class{
    var img: String? {get}
    var message: String? {get}
    var timeLastMessage: String? {get}
    var themeMessage: String? {get}
    var timeBeginDialog: String? {get}
    var countNewMessage: String? {get}
    var hideCountNewMessage: Bool? {get}
}
