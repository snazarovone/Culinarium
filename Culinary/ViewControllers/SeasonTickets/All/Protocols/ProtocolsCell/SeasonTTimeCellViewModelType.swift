//
//  SeasonTTimeCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 11.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol SeasonTTimeCellViewModelType: class {
    var viewCollection: ViewCollection? {get} //card or grid
    var seasontTicketTimeDelegate: SeasontTicketTimeDelegate? {get}
}
