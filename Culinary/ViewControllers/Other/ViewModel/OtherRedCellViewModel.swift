//
//  OtherRedCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 26.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class OtherRedCellViewModel: OtherModelType, OtherRedCellViewModelType{
    var typeCell: OthersCellType{
        return .red
    }
    
    var img: UIImage?{
        return otherRedModel.img
    }
    
    var header: String?{
        return otherRedModel.headerTitle
    }
    
    var description: String?{
        return otherRedModel.description
    }
    
    private let otherRedModel: OtherRedModel
    
    init(otherRedModel: OtherRedModel){
        self.otherRedModel = otherRedModel
    }
}
