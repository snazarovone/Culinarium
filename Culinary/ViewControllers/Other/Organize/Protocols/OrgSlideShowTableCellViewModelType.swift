//
//  OrgSlideShowTableCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol OrgSlideShowTableCellViewModelType: class {
    var items: [UIImage] {get}
    var countItems: Int {get}
}
