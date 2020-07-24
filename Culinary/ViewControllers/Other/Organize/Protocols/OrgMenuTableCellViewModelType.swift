//
//  OrgMenuTableCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol OrgMenuTableCellViewModelType: class {
    var items: [String] {get}
    var selectedItem: IndexPath {get}
}
