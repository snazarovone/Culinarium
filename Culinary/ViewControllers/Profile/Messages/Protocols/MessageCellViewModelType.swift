//
//  MessageCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 12.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol MessageCellViewModelType: class {
    var userPhoto: String? {get}
    var name: String {get}
    var timeMessage: String? {get}
    var message: String? {get}
    var isHideFileView: Bool {get}
    var images: [ImageDownloadViewModelType?] {get}
}
