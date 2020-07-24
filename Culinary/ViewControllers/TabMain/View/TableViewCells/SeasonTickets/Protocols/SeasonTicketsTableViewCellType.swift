//
//  SeasonTicketsTableViewCellType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol SeasonTicketsTableViewCellType: class {
    func numberOfRow(in section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> SeasonTCellDelegate
    var seasonTicketDelegate: SeasonTicketDelegate? {get}
    var seasonTCollectionDelegate: SeasonTCollectionDelegate? {get}
}
