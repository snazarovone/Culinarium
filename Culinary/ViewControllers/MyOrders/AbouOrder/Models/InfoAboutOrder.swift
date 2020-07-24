//
//  InfoAboutOrder.swift
//  Culinary
//
//  Created by Sergey Nazarov on 14.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

class InfoAboutOrder: AboutOrderType{
    var type: AboutOrderCellType{
        return .infoOrder
    }

    public let detailOrder: HistoryDetail
    init(detailOrder: HistoryDetail){
        self.detailOrder = detailOrder
    }
}
