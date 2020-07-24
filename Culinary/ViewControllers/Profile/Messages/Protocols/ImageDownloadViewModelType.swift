//
//  ImageDownloadViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol ImageDownloadViewModelType: class {
    var name: String? {get}
    var img: String? {get}
    var titleSize: String? {get}
}
