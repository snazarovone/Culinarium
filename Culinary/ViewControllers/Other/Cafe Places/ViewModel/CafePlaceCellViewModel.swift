//
//  CafePlaceCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 26.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import UIKit

class CafePlaceCellViewModel: CafePlaceCellViewModelType{
  
    var street: String?{
        return cafe.address
    }
    
    var nameCafe: String?{
        return cafe.title
    }
    
    var nameMetroStatetion: String?{
        return cafe.metro_station?.metro_line?.title
    }
    
    var circleColor: UIColor{
        return cafe.metro_station?.metro_line?.color?.hexStringToUIColor ?? .green
    }
    
    private let cafe: Cafe
    init(cafe: Cafe){
        self.cafe = cafe
    }
}
