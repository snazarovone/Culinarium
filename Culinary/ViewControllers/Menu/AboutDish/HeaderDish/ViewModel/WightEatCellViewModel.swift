//
//  WightEatCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 22.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class WightEatCellViewModel: WightEatCellViewModelType{
    var weight: String
    var isSelect: Bool

    var bgColor: UIColor{
        if isSelect{
            return UIColor(named: "RedA4262A")!
        }else{
            return UIColor(named: "5D5956_30")!
        }
    }
    
    var textColor: UIColor{
        if isSelect{
            return .white
        }else{
            return UIColor(named: "Black282A2F")!
        }
    }

    init(weight: Int, isSelect: Bool){
        self.weight = String(weight)
        self.isSelect = isSelect
    }
}
