//
//  AddressCafeCellModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import UIKit

class AddressCafeCellModel: AboutCafeModels, AddressCafeCellModelType{
    
    var nameCafe: String?{
        return addressCafeModel.nameCafe
    }
    
    var timeWork: String?{
        var timeW = ""
        let sTO = (addressCafeModel.open ?? "").split(separator: ":")
        timeW += "("
        if sTO.count >= 2{
            let sTO_hour = sTO[0]
            let sTO_Min = sTO[1]
            timeW += "\(sTO_hour):\(sTO_Min)"
            let sTC = (addressCafeModel.close ?? "").split(separator: ":")
            if sTO.count >= 2{
                let sTC_Hour = sTC[0]
                let sTC_Min = sTC[1]
                timeW += "-\(sTC_Hour):\(sTC_Min)"
            }
        }
        timeW += ")"
        if let working_days = addressCafeModel.working_days{
            timeW = "\(working_days) \(timeW)"
        }
        return timeW
    }
    
    var addressCafe: String?{
        return addressCafeModel.addressCafe
    }
    
    var metroName: String?{
        return addressCafeModel.metroName
    }
    
    var colorCircle: UIColor?{
        return (addressCafeModel.colorCircle ?? "").hexStringToUIColor
    }
    
    var typeCell: AboutCafeType{
        return .addressCafe
    }
    
    private let addressCafeModel: AddressCafeModel
    
    init(addressCafeModel: AddressCafeModel){
        self.addressCafeModel = addressCafeModel
    }
}
