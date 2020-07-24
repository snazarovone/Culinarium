//
//  OtherInfoCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 26.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class OtherInfoCellViewModel: OtherModelType, OtherInfoCellViewModelType{
    
    var typeCell: OthersCellType{
        return .info
    }
    
    var description: String{
        return otherInfoModel.description
    }
    
    var image: UIImage{
        return otherInfoModel.img
    }
    

    private let otherInfoModel: OtherInfoModel
    
    init(otherInfoModel: OtherInfoModel){
        self.otherInfoModel = otherInfoModel
    }
}
