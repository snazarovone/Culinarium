//
//  SaveAddressCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 17.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

class SaveAddressCellViewModel: SaveAddressCellViewModelType{
    var titleAddress: String?{
        return addressInfoUser.title
    }
    
    var address: String?{
        var otherDataAddress = ""
        if let house = addressInfoUser.house{
            otherDataAddress += " д.\(house),"
        }
        if let porch = addressInfoUser.porch{
            otherDataAddress += " п.\(porch),"
        }
        if let flat = addressInfoUser.flat{
            otherDataAddress += " кв.\(flat),"
        }
        if let floor = addressInfoUser.floor{
            otherDataAddress += " э.\(floor),"
        }
        if let doorCode = addressInfoUser.door_code{
            otherDataAddress += " код \(doorCode)"
        }
        
        if otherDataAddress.count > 0 && (otherDataAddress[otherDataAddress.index(before: otherDataAddress.endIndex)] == ","){
            otherDataAddress.removeLast()
        }
        
        if otherDataAddress == ""{
            return "г. \(addressInfoUser.city ?? ""), \(addressInfoUser.street ?? "")"
        }else{
            return "г. \(addressInfoUser.city ?? ""), \(addressInfoUser.street ?? ""),\(otherDataAddress)"
        }
    }
    
    private let addressInfoUser: AddressInfoUser
    
    init(addressInfoUser: AddressInfoUser){
        self.addressInfoUser = addressInfoUser
    }
    
}
