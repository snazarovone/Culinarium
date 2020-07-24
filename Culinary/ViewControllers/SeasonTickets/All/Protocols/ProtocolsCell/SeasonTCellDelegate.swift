//
//  SeasonTCellDelegate.swift
//  Culinary
//
//  Created by Sergey Nazarov on 11.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol SeasonTCellDelegate {
    var cellSize: CGSize {get}
    var viewCollection: ViewCollection? {get} //card or grid
    var seasonTicketsModel: SeasonTicketsModel {get}
}
