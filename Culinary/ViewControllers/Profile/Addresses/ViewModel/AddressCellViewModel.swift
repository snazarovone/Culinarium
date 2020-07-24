//
//  AddressCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class AddressCellViewModel: AddressCellViewModelType{
 
    var indexPath: IndexPath
    
    weak var delegateAddress: AddressActionDelegate?
    
  
    var address: String?{
        var otherDataAddress = ""
        if let house = addressModel?.house{
            otherDataAddress += " д.\(house),"
        }
        if let porch = addressModel?.porch{
            otherDataAddress += " п.\(porch),"
        }
        if let flat = addressModel?.flat{
            otherDataAddress += " кв.\(flat),"
        }
        if let floor = addressModel?.floor{
            otherDataAddress += " э.\(floor),"
        }
        if let doorCode = addressModel?.door_code{
            otherDataAddress += " код \(doorCode)"
        }
        
        if otherDataAddress.count > 0 && (otherDataAddress[otherDataAddress.index(before: otherDataAddress.endIndex)] == ","){
            otherDataAddress.removeLast()
        }
        
        if otherDataAddress == ""{
            return "г. \(addressModel?.city ?? ""), \(addressModel?.street ?? "")"
        }else{
            return "г. \(addressModel?.city ?? ""), \(addressModel?.street ?? ""),\(otherDataAddress)"
        }
    }
    
    var isSelect: Bool
    
    var titleAddress: String?{
        return addressModel?.title
    }
    
    private let addressModel: AddressInfoUser?
    
    init(addressModel: AddressInfoUser?, isSelect: Bool, indexPath: IndexPath, delegateAddress: AddressActionDelegate?){
        self.addressModel = addressModel
        self.isSelect = isSelect
        self.indexPath = indexPath
        self.delegateAddress = delegateAddress
    }
    
}
