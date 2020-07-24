//
//  OrgMenuTableViewCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol OrgMenuTableViewCellViewModelType {
    func cellForRow(at indexPath: IndexPath) -> BMenuCollectionCellViewModelType
    func numberOfRow(in section: Int) -> Int
    func didSelect(at indexPath: IndexPath)
    
}
