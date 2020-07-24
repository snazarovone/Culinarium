//
//  OrganizeViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol OrganizeViewModelType{
    func numberOfRow(in section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> OrganizeTableCellModelType
}
