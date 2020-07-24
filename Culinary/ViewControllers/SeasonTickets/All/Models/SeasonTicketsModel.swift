//
//  SeasonTicketsModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 11.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class SeasonTicketsModel: SeasonModelType{

    var typeSeason: SeasonTicketsModelType
    
    init(typeSeason: SeasonTicketsModelType){
        self.typeSeason = typeSeason
    }
}
